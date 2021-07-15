//
//  RenderCanvas.swift
//  Storinhas
//
//  Created by Erick Almeida on 12/07/21.
//

import SwiftUI

struct PageCanvas: View {
    @State var storyPage = StoryPage(backgroundPath: nil, elements: [
                                        PageElement(x: -0.4, y: -0.3, scale: 0.1, imagePath: .catalogedAsset(named: "TestRabbit")),
                                        PageElement(x: -0.4, y: -0.2, scale: 0.1, imagePath: .catalogedAsset(named: "TestRabbit")),
                                        PageElement(x: -0.2, y: 0.1, scale: 0.1, imagePath: .catalogedAsset(named: "TestTurtle"))])
    @Binding var storyPager: StoryPage
    let editable: Bool
    
    @State private var status: CanvasStatus = .idle
    @State private var feedback = UINotificationFeedbackGenerator()

    /* REVIEW:
     Apagar elemento
     Testar scale
     Bug de elementos idênticos no mesmo lugar
     status locked se não for editável
    */
    
    var body: some View {

        GeometryReader { metrics in
            
            if backgroundExists() {
                CustomImage(from: storyPage.backgroundPath!)
                    .resizable()
                    .scaledToFill()
            }

            ZStack {
                ForEach(storyPage.elements, id: \.self) { element in
                    
                    let offset = getOffset(metrics: metrics, element: element)
                    
                    CustomImage(from: element.imagePath)
                        .resizable()
                        .scaledToFit()
                        .offset(x: offset.x, y: offset.y)
                        .shadow(radius: getShadow(element: element))
                        .gesture((LongPressGesture(minimumDuration: 0.5)
                            .onEnded { value in
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
                                withAnimation {
                                    self.commitMove()
                                    self.status = .idle
                                }
                            })
                        )
                        .gesture(LongPressGesture(minimumDuration: 0).onEnded { value in
                            withAnimation {
                                switch self.status {
                                    case .holdingElement:
                                        self.status = .idle
                                    default: return
                                }
                            }
                        })
                        .gesture(MagnificationGesture()
                            .onChanged { value in
                                switch self.status {
                                    case .idle: break
                                    default: return
                                }
                                
                                withAnimation {
                                    self.status = .resizingTopElement(scaleOffset: value / metrics.size.width)
                                }
                            }
                            .onEnded { _ in
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
                    multiplier += 0.0125
                }
            case .resizingTopElement(let scaleOffset):
                if (storyPage.elements[getTopElementIndex()] == element) {
                    multiplier += scaleOffset
                }
            default: break
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
                storyPage.elements[getTopElementIndex()].saveTranslationOffset(x: Double(translationX), y: Double(translationY))
            }
        }
    }
    
    func commitResize() {
        if case .resizingTopElement(let scaleOffset) = self.status {
            if (storyPage.elements.count > 0) {
                storyPage.elements[getTopElementIndex()].saveScaleOffset(scaleOffset: Double(scaleOffset))
            }
        }
    }
    
    enum CanvasStatus: Equatable {
        case idle
        case holdingElement
        case movingTopElement(translationX: CGFloat, translationY: CGFloat)
        case resizingTopElement(scaleOffset: CGFloat)
    }
}

struct PageCanvas_Previews: PreviewProvider {
    static var previews: some View {
        PageCanvas(storyPager: Binding.constant(StoryPage(backgroundPath: nil, elements: [
            PageElement(x: -0.4, y: -0.2, scale: 0.1, imagePath: .catalogedAsset(named: "TestRabbit")),
            PageElement(x: -0.3, y: 0.3, scale: 0.1, imagePath: .catalogedAsset(named: "TestRabbit")),
            PageElement(x: -0.2, y: 0.1, scale: 0.1, imagePath: .catalogedAsset(named: "TestTurtle"))
        ])), editable: false)
    }
}

