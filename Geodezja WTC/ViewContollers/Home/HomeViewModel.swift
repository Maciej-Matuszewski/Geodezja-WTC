import Foundation

class HomeViewModel {
    let offers: [OfferModel] = [
        OfferModel(title: "Mapy do celów projektowych", image: #imageLiteral(resourceName: "offer_001"), description: "Mapy pod budownictwo jednorodzinne, wielorodzinne, budowę sieci uzbrojenia podziemnego, budowę dróg, koleji oraz zakładów przemysłowych."),
        OfferModel(title: "Podziały nieruchomości", image: #imageLiteral(resourceName: "offer_004"), description: "Podziały nieruchomości rolnych, wydzielenie działek budowlanych, podziały dla ZRID"),
        OfferModel(title: "Ustalenia przebiegów granic", image: #imageLiteral(resourceName: "offer_002"), description: ""),
        OfferModel(title: "Tyczenie obiektów budowlanych", image: #imageLiteral(resourceName: "offer_003"), description: "Wytyczenia wszelkich obiektów budowlanych, zarówno dla budownictwa jednorodzinnego jak i dla dużych zakładów przemysłowych oraz drogownictwa itp.")
    ]
}
