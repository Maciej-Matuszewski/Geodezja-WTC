import Foundation

class HomeViewModel {
    let offers: [OfferModel] = [
        OfferModel(title: "Mapy do celów projektowych", image: #imageLiteral(resourceName: "offer_001"), description: "Mapy pod budownictwo jednorodzinne, wielorodzinne, budowę sieci uzbrojenia podziemnego, budowę dróg, koleji oraz zakładów przemysłowych."),
        OfferModel(title: "Podziały nieruchomości", image: #imageLiteral(resourceName: "offer_004"), description: "Podziały nieruchomości rolnych, wydzielenie działek budowlanych, podziały dla ZRID"),
        OfferModel(title: "Ustalenia przebiegów granic", image: #imageLiteral(resourceName: "offer_002"), description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam pellentesque, odio eget pulvinar venenatis, est ipsum laoreet enim, sed hendrerit mauris velit quis libero. Quisque non scelerisque nulla, in laoreet felis. Cras non dignissim sem. Nunc ornare faucibus metus. Nullam at ex urna. Pellentesque ut augue in felis pharetra finibus. Quisque mattis blandit erat at varius. Nulla facilisi. Sed dapibus, nisi sed volutpat faucibus, enim ante ultrices ipsum, quis ullamcorper enim metus laoreet odio. Sed nec ipsum molestie, euismod nisi luctus, egestas purus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Curabitur elit justo, volutpat vel ligula aliquam, bibendum scelerisque sem. Donec sed molestie est. Mauris eget venenatis augue. Cras hendrerit lacinia ante.\n\nNulla lobortis metus urna, vitae posuere tellus fringilla et. Ut at tortor hendrerit, mattis ante eget, sodales mauris. Suspendisse pellentesque eleifend nunc."),
        OfferModel(title: "Tyczenie obiektów budowlanych", image: #imageLiteral(resourceName: "offer_003"), description: "Wytyczenia wszelkich obiektów budowlanych, zarówno dla budownictwa jednorodzinnego jak i dla dużych zakładów przemysłowych oraz drogownictwa itp.")
    ]
}
