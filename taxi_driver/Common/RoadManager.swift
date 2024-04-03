//
// Created by Dali on 6/20/21.
//

import Foundation
import Alamofire
import MapKit

typealias ParserJson = ([String: Any?]?) -> Road
typealias RoadHandler = (Road?) -> Void


enum RoadType: String {
    case car = "routed-car"
    case bike = "routed-bike"
    case foot = "routed-foot"
}


protocol PRoadManager {
    func getRoad(wayPoints: [String], typeRoad: RoadType, handler: @escaping RoadHandler)
}

class RoadManager: PRoadManager {
   
  

   

    private var road: Road? = nil
   
    init() {}

    func getRoad(wayPoints: [String], typeRoad: RoadType, handler: @escaping RoadHandler) {
        let serverURL = buildURL(wayPoints, typeRoad.rawValue)
        guard let url = Bundle(for: type(of: self)).url(forResource: "en", withExtension: "json") else {
            return print("File not found")
        }
        var contentLangEn: [String:Any] = [String:Any]()
        do {
            let data = try String(contentsOf: url).data(using: .utf8)
            contentLangEn = parse(jsonData: data)
        } catch let error {
            print(error)
        }

        DispatchQueue.global(qos: .background).async {
            self.httpCall(url: serverURL) { json in
                if json != nil {
                    let road = self.parserRoad(json: json!, instructionResource: contentLangEn)
                    DispatchQueue.main.async {
                        self.road = road
                        handler(road)
                    }
                } else {
                    DispatchQueue.main.async {
                        handler(nil)
                    }
                }
            }
        }
    }


    func buildURL(_ waysPoints: [String], _ typeRoad: String, alternative: Bool = false) -> String {
        let serverBaseURL = "https://routing.openstreetmap.de/\(typeRoad)/route/v1/driving/"
        let points = waysPoints.reduce("") { (result, s) in
            "\(result);\(s)"
        }
        var stringWayPoint = points
        stringWayPoint.removeFirst()


        return "\(serverBaseURL)\(stringWayPoint)?alternatives=\(alternative)&overview=full&steps=true"
    }

    private func httpCall(url: String, parseHandler: @escaping (_ json: [String: Any?]?) -> Void) {
        AF.request(url, method: .get).responseJSON { response in
            if response.data != nil {
                let data = response.value as? [String: Any?]
                parseHandler(data!)
            } else {
                parseHandler(nil)
            }
        }
    }

    private func parserRoad(json: [String: Any?], instructionResource: [String:Any]) -> Road {
        var road: Road = Road()
        if json.keys.contains("routes") {
            let routes = json["routes"] as! [[String: Any?]]
            routes.forEach { route in
                road.distance = (route["distance"] as! Double) / 1000
                road.duration = route["duration"] as! Double
                road.mRouteHigh = route["geometry"] as! String
                let jsonLegs = route["legs"] as! [[String: Any]]
                jsonLegs.enumerated().forEach { indexLeg,jLeg in
                    var legR: RoadLeg = RoadLeg()
                    legR.distance = (jLeg["distance"] as! Double) / 1000
                    legR.duration = jLeg["duration"] as! Double

                    let jsonSteps = jLeg["steps"] as! [[String: Any?]]
                    var lastName = ""
                    var lastNode: RoadNode? = nil
                    jsonSteps.enumerated().forEach { index,step in
                        let maneuver = (step["maneuver"] as! [String: Any?])
                        let location = maneuver["location"] as! [Double]
                        var node = RoadNode(
                                location: CLLocationCoordinate2D(
                                        latitude: (location)[1],
                                        longitude: (location)[0]
                                )
                        )
                        node.distance = (step["distance"] as! Double) / 1000
                        node.duration = step["duration"] as! Double
                        let roadStep = RoadStep(json: step)
                        node.instruction = roadStep.buildInstruction(instructions: instructionResource,options: [
                            "legIndex":indexLeg , "legCount" : jsonLegs.count - 1
                        ])
                        if lastNode != nil && roadStep.maneuver.maneuverType == "new name" && lastName == roadStep.name {
                            lastNode?.duration += node.duration
                            lastNode?.distance += node.distance
                        } else {
                            road.steps.append(node)
                            lastNode = node
                            lastName = roadStep.name
                        }


                    }

                }
            }
        }
        return road

    }
    private func parse(jsonData: Data?) -> [String:Any] {
        if jsonData == nil {
            return [String:Any]()
        }
        do {
            let decodedData = try JSONSerialization.jsonObject(with: jsonData!)
            return decodedData as! [String:Any]
        } catch {
            print("decode error")
        }
        return [String:Any]()
    }


 }
