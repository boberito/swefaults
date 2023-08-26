//
//import Foundation
//import Cocoa
//
//
//class cli {
//    func read(arguments: [String]) {
//        if arguments.count <= 1 {
//            exit(0)
//            
//        } else {
//            let prefs = PrefClass()
//            if arguments[1] == "--csv" {
//                
//                let contents = try NSString(contentsOfFile: arguments[2], encoding: String.Encoding.utf8.rawValue)
//                let parsedCSV: [[String]] = contents.components(separatedBy: "\n").map{ $0.components(separatedBy: ",") }
//                
//                for entry in parsedCSV {
//                    print("---------------------------------------------------")
//                    let result = prefs.prefCheck(domain: entry[0], key: entry[1])
//                    switch result.managed {
//                        case .Managed:
//                            print(result.domain!)
//                            print("\(result.key!): \(result.value!)")
//                            print("Managed")
//                        case .NotManaged:
//                            print(result.domain!)
//                            print("\(result.key!): \(result.value!)")
//                            print("Not Managed")
//                            print(result.location!)
//                        case .NotFound:
//                            print(result.domain!)
//                            print(result.key!)
//                            print("Setting not found or set")
//                    }
//                    
//                }
//                
//            } else {
//                let result = prefs.prefCheck(domain: arguments[1], key: arguments[2])
//                switch result.managed {
//                    case .Managed:
//                        print(result.domain!)
//                        print("\(result.key!): \(result.value!)")
//                        print("Managed")
//                    case .NotManaged:
//                        print(result.domain!)
//                        print("\(result.key!): \(result.value!)")
//                        print("Not Managed")
//                        print(result.location!)
//                    case .NotFound:
//                        print(result.domain!)
//                        print(result.key!)
//                        print("Setting not found or set")
//                }
//            }
//        }
//    }
//}
//
//
////
