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
    @Published var podInfoData: PodInfo? = nil
    @Published var services: [ServiceData] = []
    @Published var serviceInfoData: ServiceInfo? = nil
    @Published var ingresses: [IngressData] = []
    @Published var ingressInfoData: IngressInfo? = nil
    @Published var namespaces: [NamespaceData] = []
    @Published var clusterMetricsData: ClusterMetricInfo? = nil
    @Published var scs : [SCData] = []
    @Published var scInfoData: SCInfo? = nil
    @Published var rss: [RSData] = []
    @Published var rsInfoData: RSInfo? = nil
    //@Published var replicaSets:
    
    // Detail View Properties...
    @Published var currentService: ServiceData?
    @Published var currentPVC: PVCData?
    @Published var currentDeploy: DeployData?
    @Published var currentPod: PodData?
    //@Published var currentRS: 
    @Published var currentPV: PVData?
    @Published var currentSC: SCData?
    @Published var currentIngress: IngressData?
    @Published var currentRS: RSData?
    
    @Published var showDetail = false
    @Published var showDetailSearch = false
    @Published var currentNS = "All"
    
    @Published var searchActivated: Bool = false
    @Published var searchText: String = ""
    @Published var searchResource: resource = .deployment   //초기값으로 변경이 필요하다. 개발완료 시
    @Published var searchItem: [SearchItem] = []
    @Published var filterItem: [SearchItem] = []
    
    @Published var currentView = "Home"
    @Published var showMenu = false
    
    enum resource {
        case pv
        case pvc
        case svc
        case pod
        case deployment
        case sc
        case ingress
        case rs
    }
    
    func collectSearchData() {
        var element: SearchItem
        switch searchResource {
        case .deployment:
            for data in deploymemts {
                element = SearchItem(name: data.name, namespace: data.namespace)
                searchItem.append(element)
            }
        case .pv:
            print("collectSearchData() .pv")
            for data in pvs {
                //searchedProducts.append(String(data.name))
                element = SearchItem(name: data.name)
                searchItem.append(element)
            }
        case .pvc:
            print("collectSearchData() .pvc")
            for data in pvcs {
                element = SearchItem(name: data.name, namespace: data.namespace)
                searchItem.append(element)
            }
        case .svc:
            for data in services {
                element = SearchItem(name: data.name, namespace: data.namespace)
                searchItem.append(element)
            }
        case .pod:
            for data in pods {
                element = SearchItem(name: data.name, namespace: data.namespace)
                searchItem.append(element)
            }
        case .sc:
            for data in scs {
                element = SearchItem(name: data.name)
                searchItem.append(element)
            }
        case .ingress:
            for data in ingresses {
                //searchedProducts.append(String(data.name))
                element = SearchItem(name: data.name, namespace: data.namespace)
                searchItem.append(element)
            }
        case .rs:
            for data in rss {
                print("rs :: \(data.name)")
                element = SearchItem(name: data.name, namespace: data.namespace)
                searchItem.append(element)
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
                    print("filterProductBySearch")
                }
                else {
                    //self.filterdResource = []
                    self.filterItem = []
                }
            })
    }
    
    func filterProductBySearch() {
        
        // Filtering Product By Product Type...
        DispatchQueue.global(qos: .userInteractive).async {
            
            let results = self.searchItem
                .lazy
                .filter { product in
                    return product.name.lowercased().contains(self.searchText.lowercased())
                }
            
            DispatchQueue.main.async {
                self.filterItem = results.compactMap({ product in
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
        K8sApiService.deployList(namespace: self.currentNS)
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("K8sVM completion: \(completion)")
            } receiveValue: { (receivedData: [DeployData]) in
                print("store")
                self.deploymemts = receivedData
            }.store(in: &subscription)
    }
    
    func deployInfo(namespace: String, resourceName: String) {
        print("K8sVM: deployInfo() called")
        K8sApiService.deployInfo(namespace: namespace, resourceName: resourceName)
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("K8sVM completion: \(completion)")
            } receiveValue: { (receivedData: DeployInfo) in
                print("store")
                self.deployInfoData = receivedData
            }.store(in: &subscription)
    }
    
    func podList() {
        print("K8sVM: podList() called")
        K8sApiService.podList(namespace: currentNS)
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("K8sVM completion: \(completion)")
            } receiveValue: { (receivedData: [PodData]) in
                print("store")
                self.pods = receivedData
            }.store(in: &subscription)
    }
    
    func podInfo(namespace: String, resourceName: String) {
        print("K8sVM: podInfo() called")
        K8sApiService.podInfo(namespace: namespace, resourceName: resourceName)
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("K8sVM completion: \(completion)")
            } receiveValue: { (receivedData: PodInfo) in
                print("store")
                self.podInfoData = receivedData
            }.store(in: &subscription)
    }
    
    func rsList() {
        print("K8sVM: rsList() called")
        K8sApiService.rsList(namespace: currentNS)
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("K8sVM completion: \(completion)")
            } receiveValue: { (receivedData: [RSData]) in
                self.rss = receivedData
            }.store(in: &subscription)
    }
    
    func rsInfo(namespace: String, resourceName: String) {
        print("K8sVM: rsInfo() called")
        K8sApiService.rsInfo(namespace: namespace, resourceName: resourceName)
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("K8sVM completion: \(completion)")
            } receiveValue: { (receivedData: RSInfo) in
                self.rsInfoData = receivedData
            }.store(in: &subscription)
    }
    
    func serviceList() {
        print("K8sVM: serviceList() called")
        K8sApiService.serviceList(namespace: currentNS)
            .sink {  (completion: Subscribers.Completion<AFError>) in
                print("K8sVM completion: \(completion)")
            } receiveValue: { (receivedData: [ServiceData]?) in
                debugPrint(receivedData ?? [])
                self.services = receivedData ?? []
            }.store(in: &subscription)
    }
    
    func serviceInfo(resourceName: String) {
        print("K8sVM: serviceInfo() called")
        K8sApiService.serviceInfo(namespace: currentNS, resourceName: resourceName)
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("K8sVM completion: \(completion)")
            } receiveValue: { (receivedData: ServiceInfo) in
                self.serviceInfoData = receivedData
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
    
    func ingressInfo(namespace: String, resourceName: String) {
        print("K8sVM: ingressInfo() called")
        K8sApiService.ingressInfo(namespace: namespace, resourceName: resourceName)
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("K8sVM completion: \(completion)")
            } receiveValue: { (receivedData: IngressInfo) in
                self.ingressInfoData = receivedData
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
    
    func pvInfo(resourceName: String) {
        print("K8sVM: pvInfo() called")
        K8sApiService.pvInfo(resourceName: resourceName)
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("K8sVM completion: \(completion)")
            } receiveValue: { (receivedData: PVInfo) in
                //print("store")
                //print("capacity \(receivedData.resourcePVC.capacity)")
                self.pvInfoData = receivedData
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
    
    func clusterMetricInfo() {
        print("K8sVM: clusterMetricInfo() called")
        K8sApiService.clusterMetricInfo()
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("K8sVM completion: \(completion)")
            } receiveValue: { (receivedData: ClusterMetricInfo) in
                self.clusterMetricsData = receivedData
            }.store(in: &subscription)
    }
    
    func scList() {
        print("K8sVM: scList() called")
        K8sApiService.scList(namespace: currentNS)
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("K8sVM completion: \(completion)")
                     } receiveValue: { (receivedData: [SCData]) in
                print("store")
                         self.scs = receivedData
            }.store(in: &subscription)
    }
    
    func scInfo(resourceName: String) {
        print("K8sVM: scInfo() called")
        K8sApiService.scInfo(nemespace: currentNS, resourceName: resourceName)
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("K8sVM completion: \(completion)")
            } receiveValue: { (receivedData: SCInfo) in
                self.scInfoData = receivedData
            }.store(in: &subscription)
    }
}
