//
//  K8sVM.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/09/29.
//

import Foundation
import Alamofire
import Combine

class K8sVM: ObservableObject {

    // MARK: - Properties
    var subscription = Set<AnyCancellable>()
    
    @Published var pvcs : [PVCData] = []
    @Published var pvcInfoData: PVCInfo? = nil
    @Published var pvs : [PVData] = []
    @Published var pvInfoData: PVInfo? = nil
    @Published var deploymemts: [DeployData] = []
    @Published var deployInfoData: DeployInfo? = nil
    @Published var pods: [PodData] = []
    @Published var services: [ServiceData] = []
    @Published var ingresses: [IngressData] = []
    @Published var namespaces: [NamespaceData] = []
    
    // Detail View Properties...
    @Published var currentService: ServiceData?
    @Published var currentPVC: PVCData?
    @Published var currentDeploy: DeployData?
    @Published var currentPV: PVData?
    @Published var showDetail = false
    @Published var currentNS = "All"
    
    @Published var searchActivated: Bool = false
    @Published var searchText: String = ""
    @Published var searchResource: resource = .deployment
    @Published var searchedProducts: [String] = []
    @Published var filterdResource: [String] = []
    
    enum resource {
        case pv
        case pvc
        case svc
        case pod
        case deployment
    }
    
    func collectSearchData() {
        print("collectSearchData")
        print(searchResource)
        searchedProducts = []
        switch searchResource {
        case .deployment:
            for data in deploymemts {
                searchedProducts.append(String(data.name))
            }
        case .pv:
            for data in pvs {
                searchedProducts.append(String(data.name))
            }
        case .pvc:
            for data in pvcs {
                searchedProducts.append(String(data.name))
            }
        case .svc:
            for data in services {
                searchedProducts.append(String(data.name))
            }
        case .pod:
            for data in pods {
                searchedProducts.append(String(data.name))
            }
        }
    }
    var searchCancellable: AnyCancellable?
    
    init()
    {
        
        searchCancellable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str != "" {
                    self.filterProductBySearch()
                }
                else {
                    self.filterdResource = []
                }
            })
    }
    
    func filterProductBySearch() {
        
        // Filtering Product By Product Type...
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.searchedProducts
            // Since it will repuire more memory so were using lazy to perform more...
                .lazy
                .filter { product in
                    return product.lowercased().contains(self.searchText.lowercased())
                }
            
            DispatchQueue.main.async {
                self.filterdResource = results.compactMap({ product in
                    return product
                })
            }
        }
    }
    
    func pvcList() {
        print("K8sVM: pvcList() called")
        K8sApiService.PVCList(namespace: self.currentNS)
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("K8sVM completion: \(completion)")
                     } receiveValue: { (receivedData: [PVCData]) in
                print("store")
                         self.pvcs = receivedData
            }.store(in: &subscription)
    }
    
    func pvcInfo(namespace: String, resourceName: String) {
        print("K8sVM: pvcInfo() called")
        K8sApiService.pvcInfo(namespace: namespace, resourceName: resourceName)
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("K8sVM completion: \(completion)")
            } receiveValue: { (receivedData: PVCInfo) in
                print("store")
                print("capacity \(receivedData.resourcePVC.capacity)")
                self.pvcInfoData = receivedData
            }.store(in: &subscription)
    }
    
    func deployList() {
        print("K8sVM: deployList() called")
        K8sApiService.deployList()
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("K8sVM completion: \(completion)")
            } receiveValue: { (receivedData: [DeployData]) in
                print("store")
                self.deploymemts = receivedData
            }.store(in: &subscription)
    }
    
    func deployInfo(namespace: String, resourceName: String) {
        print("K8sVM: deployInfo() called")
        K8sApiService.deployInfo(nemespace: namespace, resourceName: resourceName)
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("K8sVM completion: \(completion)")
            } receiveValue: { (receivedData: DeployInfo) in
                print("store")
                self.deployInfoData = receivedData
            }.store(in: &subscription)
    }
    
    func podList() {
        print("K8sVM: podList() called")
        K8sApiService.podList()
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("K8sVM completion: \(completion)")
            } receiveValue: { (receivedData: [PodData]) in
                print("store")
                self.pods = receivedData
            }.store(in: &subscription)
    }
    
    func serviceList() {
        print("K8sVM: serviceList() called")
        K8sApiService.serviceList(namespace: currentNS)
            .sink {  (completion: Subscribers.Completion<AFError>) in
                print("K8sVM completion: \(completion)")
            } receiveValue: { (receivedData: [ServiceData]) in
                self.services = receivedData
            }.store(in: &subscription)
    }
    
    func pvList() {
        print("K8sVM: pvList() called")
        K8sApiService.PVList()
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("K8sVM completion: \(completion)")
                     } receiveValue: { (receivedData: [PVData]) in
                print("store")
                         self.pvs = receivedData
            }.store(in: &subscription)
    }
    
    func ingressList() {
        print("K8sVM: ingressList() called")
        K8sApiService.IngressList(namespace: currentNS)
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("K8sVM completion: \(completion)")
                     } receiveValue: { (receivedData: [IngressData]) in
                print("store")
                         self.ingresses = receivedData
            }.store(in: &subscription)
    }
    
    func namespaceList() {
        print("K8sVM: namespaceList() called")
        K8sApiService.namespaceList()
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("K8sVM completion: \(completion)")
                     } receiveValue: { (receivedData: [NamespaceData]) in
                print("store")
                         self.namespaces = receivedData
            }.store(in: &subscription)
    }
}
