//
//  RenderCanvas.swift
//  Storinhas
//
//  Created by Erick Almeida on 12/07/21.
//

import SwiftUI

struct PageCanvas: View {
    
    @Binding var storyPage: StoryPage
    let editable: Bool
    
    @State private var status: CanvasStatus = .idle
    @State private var isDropping: Bool = false
    @State private var feedback = UINotificationFeedbackGenerator()
    @State var currentTextBinding: Binding<String>? = nil

    /* REVIEW:
     Bug offbounds
     Bug de elementos idênticos no mesmo lugar
     Inverter
     Refatorar
    */
    
    var body: some View {

        GeometryReader { metrics in
            
            if backgroundExists() {
                CustomImage(from: storyPage.backgroundPath!)
                    .resizable()
                    .scaledToFill()
            }

            ZStack {
                
                /* Text(getDebugText()) */

                if (isMovingElement()) {
                    Image(systemName: "trash.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color("Coral"))
                        .frame(width: getTrashScale(metrics: metrics))
                        .padding(8)
                        .background(Color("Barbie"))
                        .cornerRadius(256)
                        .transition(.offset(y: metrics.size.height * -0.6))
                        .animation(.easeInOut)
                        .offset(x:metrics.size.width * 0.4, y: metrics.size.height * -0.35)
                }
                
                ForEach(storyPage.elements, id: \.self) { element in
                    
                    let offset = getOffset(metrics: metrics, element: element)
                    
                    CustomImage(from: element.imagePath)
                        .resizable()
                        .scaledToFit()
                        .offset(x: offset.x, y: offset.y)
                        .shadow(radius: getShadow(element: element))
                        .gesture((LongPressGesture(minimumDuration: 0.1)
                            .onEnded { value in
                                if !editable { return }

                                withAnimation {
                                    switch self.status {
                                        case .idle:
                                            self.feedback.notificationOccurred(.success)
                                            self.bringElementToTop(element: element)
                                            self.status = .holdingElement
                                        default: return
                                    }
                                }
                            }
                        ).sequenced(before: DragGesture()
                            .onChanged { value in
                                if !editable { return }
                                
                                switch self.status {
                                    case .holdingElement, .movingTopElement: break
                                    default: return
                                }
                                
                                withAnimation {
                                    self.status = .movingTopElement(
                                        translationX: value.translation.width / metrics.size.width,
                                        translationY: value.translation.height / metrics.size.height)
                                }
                            }
                            .onEnded { _ in
                                if !editable { return }
                                self.commitMove()
                                self.status = .idle
                            })
                        )
                        .gesture(LongPressGesture(minimumDuration: 0).onEnded { value in
                            if !editable { return }

                            withAnimation {
                                switch self.status {
                                    case .holdingElement:
                                        self.status = .idle
                                    default: return
                                }
                            }
                        })
                        .gesture(MagnificationGesture(minimumScaleDelta: CGFloat.leastNonzeroMagnitude)
                            .onChanged { value in
                                if !editable { return }
                                
                                switch self.status {
                                    case .idle, .resizingTopElement: break
                                    default: return
                                }
                                
                                withAnimation {
                                    self.status = .resizingTopElement(scaleMultiplier: value)
                                }
                            }
                            .onEnded { _ in
                                if !editable { return }

                                withAnimation {
                                    self.commitResize()
                                    self.status = .idle
                                }
                            })
                        .frame(width: getScale(metrics: metrics, element: element))
                    
                    if case .catalogedAssetWithOverlaidText(_, let overlaidText) = element.imagePath {
                        
                        Text(overlaidText)
                            .font(Theming.fonts.body)
                            .foregroundColor(Color("DarkPurple"))
                            .multilineTextAlignment(.center)
                            .offset(x: offset.x, y: offset.y)
                            .padding(24)
                            .onTapGesture {
                                if !editable { return }
                                
                                switch self.status {
                                    case .idle: break
                                    default: return
                                }
                                
                                withAnimation {
                                    currentTextBinding = getElementTextBinding(element: element)
                                    status = .editingElement
                                }
                            }
                            .frame(width: getScale(metrics: metrics, element: element))
                            
                    }
                }
            }
            .onDrop(of: [.image], isTargeted: $isDropping, perform: {itemProviders, coordinates in
                var result = false
                  
                for provider in itemProviders {
                  if provider.canLoadObject(ofClass: UIImage.self) {
                    result = true
                    provider.loadObject(ofClass: UIImage.self) { image, error in
                        if let _ = image as? UIImage {

                            DispatchQueue.main.async {
                                storyPage.elements.append(PageElement(x: 0, y: 0, scale: 0.1, imagePath: .externalImage(uiImage: image as! UIImage)))
                            }
                        }
                    }
                  }
                }
                return result
            })
            .overlay(textEditingOverlay)
            .frame(width: metrics.size.width, height: metrics.size.height)
        }
    }
    
    var textEditingOverlay: some View {
        ZStack {
            if case .editingElement = status {
                VStack {
                        HStack {
                            Text("EDIT_TEXT")
                                .font(Theming.fonts.title)
                                .foregroundColor(Color("DarkPurple"))
                                .padding(.leading, 32)
                                .padding(.top, 4)
                            Spacer()
                            Button(
                               action: {
                                    withAnimation {
                                        status = .idle
                                        if (currentTextBinding?.wrappedValue == "") {
                                            currentTextBinding?.wrappedValue = NSLocalizedString("EDIT_TEXT", comment: "")
                                        }
                                    }
                                
                                    currentTextBinding = nil
                                    backup()
                               }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(Color("DarkPurple"))
                                        .font(.largeTitle)
                                }
                        }.padding(.top)
                        .padding(.trailing)

                        TextEditor(text: currentTextBinding!)
                            .font(Theming.fonts.body)
                            .foregroundColor(Color("DarkPurple"))
                            .padding()
                            .cornerRadius(30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Theming.gradients.purple, lineWidth: 4)
                            )
                            .padding()
                            .frame(width: 400, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                     
                     }.background(Rectangle()
                                     .cornerRadius(30)
                                     .shadow(radius: 20)
                                     .foregroundColor(.white))
            }
        }
             
    }
    
    func backgroundExists() -> Bool {
        return storyPage.backgroundPath != nil
    }
    
    func isMovingElement() -> Bool {
        switch self.status {
            case .holdingElement, .movingTopElement: return true
            default: return false;
        }
    }
    
    func isElementWithinTrashBoundaries() -> Bool {
        if case .movingTopElement(let translationX, let translationY) = self.status {
            if storyPage.elements.count > 0 &&
                storyPage.elements[getTopElementIndex()].x + Double(translationX) > 0.35 &&
                storyPage.elements[getTopElementIndex()].x + Double(translationX) < 0.45 &&
                storyPage.elements[getTopElementIndex()].y + Double(translationY) > -0.40 &&
                storyPage.elements[getTopElementIndex()].y + Double(translationY) < -0.30
                {
                return true
            }
        }
        
        return false
    }
    /*
    func getDebugText() -> String {
        switch self.status {
        case .holdingElement:
            return "Holding element"
        case .idle:
            return "Idle"
        case .movingTopElement(let translationX, let translationY):
            return "Moving top element (offset: \(translationX), \(translationY))"
        case .resizingTopElement(let scaleMultiplier):
            return "Resizing top element (multiplier \(scaleMultiplier))"
        }
    } */
    
    func bringElementToTop(element: PageElement) {
        if let i = storyPage.elements.firstIndex(of: element) {
            if (storyPage.elements.count > 1) {
                storyPage.elements.remove(at: i)
                storyPage.elements.append(element)
            }
        }
    }
    
    func getTopElementIndex() -> Int {
        return storyPage.elements.count - 1
    }

    func getOffset(metrics: GeometryProxy, element: PageElement) -> CGPoint {
        
        var xMultiplier = CGFloat(element.x)
        var yMultiplier = CGFloat(element.y)
        
        if case .movingTopElement(let translationX, let translationY) = self.status {
            if (storyPage.elements[getTopElementIndex()] == element) {
                xMultiplier += translationX
                yMultiplier += translationY
            }
                return CGPoint(x: metrics.size.width * xMultiplier, y: metrics.size.height * yMultiplier)
        }
        
        return CGPoint(x: metrics.size.width * CGFloat(element.x), y: metrics.size.height * CGFloat(element.y))
    }
    
    func getScale(metrics: GeometryProxy, element: PageElement) -> CGFloat {
        
        var multiplier = CGFloat(element.scale)
        
        switch self.status {
            case .holdingElement, .movingTopElement:
                if (storyPage.elements[getTopElementIndex()] == element) {
                    multiplier *= 1.1
                }
            case .resizingTopElement(let scaleMultiplier):
                if (storyPage.elements[getTopElementIndex()] == element) {
                    multiplier *= scaleMultiplier
                }
            default: break
        }
        
        return metrics.size.width * multiplier
    }
    
    func getTrashScale(metrics: GeometryProxy) -> CGFloat {
        var multiplier: CGFloat = 0.1
        
        switch self.status {
            case .movingTopElement:
                if (isElementWithinTrashBoundaries()) {
                    multiplier = 0.15
                }
            default: break;
        }
        
        return metrics.size.width * multiplier
        
    }
    
    func getShadow(element: PageElement) -> CGFloat {
        switch self.status {
            case .holdingElement, .movingTopElement:
                if (storyPage.elements[getTopElementIndex()] == element) {
                    return 8
                }
            default: break;
        }
        return 0
    }
    
    func getElementBinding(element: PageElement) -> Binding<PageElement>? {
        if let i = storyPage.elements.firstIndex(of: element) {
            return $storyPage.elements[i]
        }
        return nil
    }
    
    func getElementTextBinding(element: PageElement) -> Binding<String>? {
        if let i = storyPage.elements.firstIndex(of: element) {
            return Binding<String>(
                get: {
                    if case .catalogedAssetWithOverlaidText(_, let text) = storyPage.elements[i].imagePath {
                        return text
                    }
                    return ""
                },
                set: { value in
                    if case .catalogedAssetWithOverlaidText(let assetName, _) = storyPage.elements[i].imagePath {
                        storyPage.elements[i].imagePath = .catalogedAssetWithOverlaidText(named: assetName, overlaidText: value)
                    }
                }
            )
        }
        return nil
    }
    
    func commitMove() {
        if case .movingTopElement(let translationX, let translationY) = self.status {
            if (storyPage.elements.count > 0) {
                if (isElementWithinTrashBoundaries()) {
                    commitRemove()
                    return;
                }
                storyPage.elements[getTopElementIndex()].saveTranslationOffset(x: Double(translationX), y: Double(translationY))
                backup()
            }
        }
    }
    
    func commitRemove() {
        storyPage.elements.removeLast()
        backup()
    }
    
    func commitHorizontalFlipToggle() {
        storyPage.elements[getTopElementIndex()].toggleHorizontalFlip()
        backup()
    }
    
    func commitResize() {
        if case .resizingTopElement(let scaleMultiplier) = self.status {
            if (storyPage.elements.count > 0) {
                storyPage.elements[getTopElementIndex()].saveScaleMultiplier(scaleMultiplier: Double(scaleMultiplier))
                backup()
            }
        }
    }
    
    func backup() {
        storyPage.history.backup(storyPage)
    }
    
    func undo() {
        if (!storyPage.history.undoAvailable) { return }
        
        let undoneStoryPage = storyPage.history.undo()
        storyPage = undoneStoryPage!
    }
    
    func redo() {
        if (!storyPage.history.redoAvailable) { return }
        
        let redoneStoryPage = storyPage.history.redo()
        storyPage = redoneStoryPage!
    }
    
    enum CanvasStatus: Equatable {
        case idle
        case holdingElement
        case movingTopElement(translationX: CGFloat, translationY: CGFloat)
        case resizingTopElement(scaleMultiplier: CGFloat)
        case editingElement
    }
}

struct PageCanvas_Previews: PreviewProvider {
    static var previews: some View {
        PageCanvas(storyPage: Binding.constant(StoryPage(backgroundPath: nil, elements: [
            PageElement(x: -0.4, y: -0.2, scale: 0.1, imagePath: .catalogedAsset(named: "TestRabbit")),
            PageElement(x: -0.3, y: 0.3, scale: 0.1, imagePath: .catalogedAsset(named: "TestRabbit")),
            PageElement(x: -0.2, y: 0.1, scale: 0.1, imagePath: .catalogedAsset(named: "TestTurtle"))
        ], history: StoryPageHistory())), editable: true)
    }
}
