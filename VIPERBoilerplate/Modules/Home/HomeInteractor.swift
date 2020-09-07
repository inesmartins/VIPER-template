import Foundation

protocol HomeInteractorType {}
protocol HomePresenterToInteractorDelegate: AnyObject {}

final class HomeInteractor {}

extension HomeInteractor: HomeInteractorType {}
extension HomeInteractor: HomePresenterToInteractorDelegate {}
