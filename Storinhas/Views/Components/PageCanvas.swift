//
//  PageCanvas.swift
//  Storinhas
//
//  Created by Nadia Bordoni on 22/07/21.
//

import SwiftUI

struct PageCanvas: View {
    
    @Binding var storyPage: StoryPage
    let editable: Bool
    
    @State private var status: CanvasStatus = .idle
    @State private var feedback = UINotificationFeedbackGenerator()

    /* REVIEW:
     Bug offbounds
     Bug de elementos idênticos no mesmo lugar
     Balões
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
                
                if (storyPage.history.undoAvailable) {
                    Button(action: undo) {
                        Text("Undo")
                    }
                }
                
                if (storyPage.history.redoAvailable) {
                    Button(action: redo) {
                        Text("Redo")
                    }.offset(y: metrics.size.height * 0.1)
                }
                
                if (isMovingElement()) {
                    Image(systemName: "trash.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color("Coral"))
                        .frame(width: getTrashScale(metrics: metrics))
                        .transition(.offset(y: metrics.size.height * 0.6))
                        .animation(.easeInOut)
                        .offset(y: metrics.size.height * 0.44)
                }
                
                ForEach(storyPage.elements, id: \.self) { element in
                    
                    let offset = getOffset(metrics: metrics, element: element)
                    
                    CustomImage(from: element.imagePath)
                        .resizable()
                        .scaledToFit()
                        .offset(x: offset.x, y: offset.y)
                        .shadow(radius: getShadow(element: element))
                        .gesture((LongPressGesture(minimumDuration: 0.5)
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

                                withAnimation {
                                    self.commitMove()
                                    self.status = .idle
                                }
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
                }
            }.frame(width: metrics.size.width, height: metrics.size.height)
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
                storyPage.elements[getTopElementIndex()].x + Double(translationX) > -0.05 &&
                storyPage.elements[getTopElementIndex()].x + Double(translationX) < 0.05 &&
                storyPage.elements[getTopElementIndex()].y + Double(translationY) > 0.425
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