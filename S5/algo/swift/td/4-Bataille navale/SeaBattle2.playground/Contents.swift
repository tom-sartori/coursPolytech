//#-hidden-code
import Foundation
import UIKit
import PlaygroundSupport


// ----------------------------------------------------------------------------------------------
// ----------------------------------- Les Types Abstraits --------------------------------------
// ----------------------------------------------------------------------------------------------


protocol TLocation{
    /// Création d'une `TLocation` : elle ne contient pas de bateau et n'a pas été touchée
    ///
    /// init: `➝ Location `
    /// - *isHit(init(),x,y)==`false`*
    /// - *shipHasBeenSet(init(),x,y) == false*
    init()
    
    /// la `TLocation` est-elle occupée en ce moment ?
    ///
    /// isOccupied: `Location ➝ Bool`
    /// - *isOccupied(l) => shipHasBeenSet(l) && !isHit(l)*
    var isOccupied : Bool { get }
    
    /// la `TLocation` a-t-elle été visée (`shoot`) ?
    ///
    /// **isHit**: `Location ➝ Bool`
    /// - *(isHit(l) => shoot(l))*
    var isHit : Bool { get }
    
    /// Un bateau a-t-il été coulé à cette `Location`?
    ///
    /// **isSunk**: `Location ➝ Bool`
    /// - *isSunk(l) => shipHasBeenSet(l) && isHit(l)*
    var isSunk : Bool { get }
    
    /// Un bateau a-t-il été placé sur cette `TLocation` ? Il peut avoir été coulé depuis.
    ///
    /// **shipHasBeenSet**: `TLocation  ➝ Bool`
    /// - *shipHasBeenSet(l) => setShip(l)*
    var shipHasBeenSet : Bool { get }
    
    /// Place un bateau sur la `TLocation`
    ///
    /// **setShip**: `Location ➝ Location`
    /// - *shipHasBeenSet(setShip(l))==True*
    mutating func setShip()
    
    /// tire sur la `TLocation`
    ///
    /// **shoot**: `Location ➝ Location`
    /// - *isHit(shoot(l) == True*
    mutating func shoot()
}

protocol TBattle{
    /// Création d'un `TBattle` : initialise le champ de bataille en plaçant *n* bateaux sur la grille ; les positions occupées par les *n* bateaux placés sont occupées, aucun bateau n'est coulé et aucune case n'est touchée, la bataille n'est pas terminée.
    ///
    /// **init**: `➝ TBattle`
    /// - shipsStillAlive(init())==*n*
    init()
    
    /// nombre de bateaux qui n'ont pas encore été coulés
    ///
    /// shipsStillAlive: `TBattle ➝ Int`
    /// - shipsStillAlive(b) == *n* - *s* où *s* est le nombre de bateaux coulés
    var shipsStillAlive : Int{ get }
    
    /// La position (x,y) est-elle occupée par un bateau qui n'a pas encore été coulé
    ///
    /// isOccupied: `TBattle x Int x Int ➝ Bool`
    /// - *isOccupied(b,x,y) => setShip(b,x,y) && !isHitAt(b,x,y)
    ///
    /// - parameters:
    ///     - x: la colonne de la position visée
    ///     - y: la ligne de la position visée
    func isOccupied(x: Int, y: Int) -> Bool
    
    /// A-t-on tiré sur (x,y) ?
    ///
    /// isHitAt: `TBattle x Int x Int ➝ Bool`
    /// - *isHitAt(shoot(b,x,y),x,y) == true* || *(isHitAt(init(),x,y) == false)*
    ///
    /// - parameters:
    ///     - x: la colonne de la position visée
    ///     - y: la ligne de la position visée
    func isHitAt(x: Int, y:Int) -> Bool
    
    /// place un bateau à la position (x,y) ; le nombre de bateaux encore en vie est incrémenté
    ///
    /// setShipAt: `TBattle x Int x Int ➝ TBattle`
    /// - isOccupied(setShip(b,x,y)) || isSunk(shoot(setShipAt(b,x,y),x,y),x,y)
    /// - shipsStillAlive(setShip(b,x,y)) == shipsStillAlive(b) + 1
    ///
    /// - parameters:
    ///     - x: la colonne de la position visée
    ///     - y: la ligne de la position visée
    mutating func setShipAt(x:Int, y: Int)
    
    /// Tire sur la position (x,y)
    ///
    /// shootAt: `TBattle x Int x Int ➝ TBattle x Bool`
    /// - shootAt(setShip(b,x,y),x,y) == true => isOccupied(b,x,y)
    /// - shootAt(b,x,y) == false => !isOccupied(b,x,y)
    /// - (bs,s) = shootAt(b,x,y) alors isHit(bs) == True
    /// - (bs,s) = shootAt(b,x,y) alors shipsStillAlive(bs) == shipsStillAlive(b)-1
    ///
    /// - parameters:
    ///     - x: la colonne de la position visée
    ///     - y: la ligne de la position visée
    mutating func shootAt(x: Int,y: Int) -> Bool
    
    /// la bataille est-elle finie ?
    ///
    /// endOfBattle: `TBattle ➝ Bool`
    /// - endOfBattle(b) => shipsStillAlive(b) == 0
    var endOfBattle : Bool { get }
    
    /// un bateau encore en vie est-il encore présent sur la même ligne et/ou colonne ?
    ///
    /// isSeenFrom: `TBattle x Int x Int ➝ Bool`
    /// - isSeenFrom(b,x,y) => isOccupied(x,l) || isOccupied(c,y) pour tout 0 ≤ l,c < 10
    ///
    /// - parameters:
    ///     - x: la colonne de la position visée
    ///     - y: la ligne de la position visée
    func isSeenFrom(x: Int, y: Int) -> Bool
}



// ----------------------------------------------------------------------------------------------
// ----------------------------------- Les Types Concrets ---------------------------------------
// ----------------------------------------------------------------------------------------------


struct Location : TLocation{
    private var _hit  : Bool = false
    private var _ship : Bool = false
    
    /// Création d'une `TLocation` : elle ne contient pas de bateau et n'a pas été touchée
    ///
    /// init: `➝ Location `
    /// - *isHit(init())==`false`*
    /// - *shipHasBeenSet(init()) == false*
    init(){ }
    
    /// la `TLocation` est-elle occupée en ce moment ?
    ///
    /// isOccupied: `Location ➝ Bool`
    /// - *isOccupied(l) => shipHasBeenSet(l) && !isHit(l)*
    var isOccupied : Bool { return self.shipHasBeenSet && !self.isHit }
    
    /// la `TLocation` a-t-elle été visée (`shoot`) ?
    ///
    /// isHit: `Location ➝ Bool`
    /// - *(isHit(l) => shoot(l))*
    var isHit : Bool { return self._hit }
    
    /// Un bateau a-t-il été coulé à cette `Location`?
    ///
    /// isSunk: `Location ➝ Bool`
    /// - *isSunk(l) => shipHasBeenSet(l) && isHit(l)*
    var isSunk : Bool { return  self.shipHasBeenSet && self.isHit }
    
    /// Un bateau a-t-il été placé sur cette `TLocation` ? Il peut avoir été coulé depuis.
    ///
    /// shipHasBeenSet: `TLocation  ➝ Bool`
    /// - *shipHasBeenSet(l) => setShip(l)*
    var shipHasBeenSet : Bool { return self._ship }
    
    /// Place un bateau sur la `TLocation`
    ///
    /// setShip: `Location ➝ Location`
    /// - *shipHasBeenSet(setShip(l))==True*
    mutating func setShip(){
        self._ship = true
    }
    /// tire sur la `TLocation`
    ///
    /// shoot: `Location ➝ Location`
    /// - *isHit(shoot(l) == True*
    mutating func shoot(){
        self._hit = true
    }
}



struct Battle : TBattle{
    private var grid : [[TLocation]]
    private var shipsNotSunk : Int = 0
    
    /// Création d'un `TBattle` : initialise le champ de bataille en plaçant *n* bateaux sur la grille ; les positions occupées par les *n* bateaux placés sont occupées, aucun bateau n'est coulé et aucune case n'est touchée, la bataille n'est pas terminée.
    ///
    /// **init**: `➝ TBattle`
    /// - shipsStillAlive(init())==*n*
    init(){
        self.grid = [[Location]](repeating: [Location](repeating: Location(), count: 10), count: 10)
        for pos in [(x: 0, y: 0),(x: 3, y: 5),(x: 8, y: 5),(x:2, y: 8),(x: 7, y: 6)]{
            setShipAt(x: pos.x, y: pos.y)
        }
    }
    
    /// nombre de bateaux qui n'ont pas encore été coulés
    ///
    /// shipsStillAlive: `TBattle ➝ Int`
    /// - shipsStillAlive(b) == *n* - *s* où *s* est le nombre de bateaux coulés
    var shipsStillAlive : Int { return self.shipsNotSunk }
    
    /// La position (x,y) est-elle occupée par un bateau qui n'a pas encore été coulé
    ///
    /// isOccupied: `TBattle x Int x Int ➝ Bool`
    /// - *isOccupied(b,x,y) => setShip(b,x,y) && !isHitAt(b,x,y)
    ///
    /// - parameters:
    ///     - x: la colonne de la position visée
    ///     - y: la ligne de la position visée
    func isOccupied(x: Int, y: Int) -> Bool{
        return self.grid[x][y].shipHasBeenSet  && !self.grid[x][y].isSunk
    }
        
    /// A-t-on tiré sur (x,y) ?
    ///
    /// isHitAt: `TBattle x Int x Int ➝ Bool`
    /// - *isHitAt(shoot(b,x,y),x,y) == true* || *(isHitAt(init(),x,y) == false)*
    ///
    /// - parameters:
    ///     - x: la colonne de la position visée
    ///     - y: la ligne de la position visée
    func isHitAt(x: Int, y:Int) -> Bool{
        return self.grid[x][y].isHit
    }
    
    /// place un bateau à la position (x,y) ; le nombre de bateaux encore en vie est incrémenté
    ///
    /// setShipAt: `TBattle x Int x Int ➝ TBattle`
    /// - isOccupied(setShip(b,x,y)) || isSunk(shoot(setShipAt(b,x,y),x,y),x,y)
    /// - shipsStillAlive(setShip(b,x,y)) == shipsStillAlive(b) + 1
    ///
    /// - parameters:
    ///     - x: la colonne de la position visée
    ///     - y: la ligne de la position visée
    mutating func setShipAt(x:Int, y: Int){
        self.grid[x][y].setShip()
        self.shipsNotSunk += 1
    }
    /// Tire sur la position (x,y)
    ///
    /// shootAt: `TBattle x Int x Int ➝ TBattle x Bool`
    /// - shootAt(setShip(b,x,y),x,y) == true => isOccupied(b,x,y)
    /// - shootAt(b,x,y) == false => !isOccupied(b,x,y)
    /// - (bs,s) = shootAt(b,x,y) alors isHit(bs) == True
    /// - (bs,s) = shootAt(b,x,y) alors shipsStillAlive(bs) == shipsStillAlive(b)-1
    ///
    /// - parameters:
    ///     - x: la colonne de la position visée
    ///     - y: la ligne de la position visée
    mutating func shootAt(x: Int,y: Int) -> Bool {
        if self.grid[x][y].shipHasBeenSet && !self.grid[x][y].isHit{
            // if there is a boat and it has not yet been hit, it will be sunk now
            self.shipsNotSunk -= 1
        }
        self.grid[x][y].shoot()
        guard self.grid[x][y].shipHasBeenSet else { return false }
        return true
    }
    
    /// la bataille est-elle finie ?
    ///
    /// endOfBattle: `TBattle ➝ Bool`
    /// - endOfBattle(b) => shipsStillAlive(b) == 0
    var endOfBattle : Bool {
        return self.shipsStillAlive == 0
    }
    
    private func isSeenX(x: Int) -> Bool{
        var seen : Bool = false
        var y : Int = 0
        while (y<10) && !seen{
            seen = self.grid[x][y].isOccupied
            y += 1
        }
        return seen
    }
    private func isSeenY(y: Int) -> Bool{
        var seen : Bool = false
        var x : Int = 0
        while (x<10) && !seen{
            seen = self.grid[x][y].isOccupied
            x += 1
        }
        return seen
    }

    /// un bateau encore en vie est-il encore présent sur la même ligne et/ou colonne ?
    ///
    /// isSeenFrom: `TBattle x Int x Int ➝ Bool`
    /// - isSeenFrom(b,x,y) => isOccupied(x,l) || isOccupied(c,y) pour tout 0 ≤ l,c < 10
    ///
    /// - parameters:
    ///     - x: la colonne de la position visée
    ///     - y: la ligne de la position visée
    func isSeenFrom(x: Int, y: Int) -> Bool {
        return self.isSeenX(x: x) || self.isSeenY(y: y)
    }
}

// ----------------------------------------------------------------------------------------------
// ----------------------------------- Interface Graphique  -------------------------------------
// ----------------------------------------------------------------------------------------------


let cellWidth : Int = 30
//let hitColor = UIColor(red: 0.820, green: 0.031, blue: 0.094, alpha: 0.9).cgColor
let hitColor = UIColor(red: 246.0/255.0, green: 108.0/255.0, blue: 116.0/255.0, alpha: 1.0)
//let targetedColor = UIColor(red: 0.824, green: 0.863, blue: 0.745,alpha: 0.9).cgColor
let targetedColor = UIColor(red: 61.0/255.0, green: 120.0/255.0, blue: 153.0/255.0, alpha: 1.0)
//let shipColor = UIColor(red: 0.561, green: 0.651, blue: 0.318,alpha:0.9).cgColor
let shipColor = UIColor(red: 153.0/255.0, green: 151.0/255.0, blue: 69.0/255.0, alpha: 1.0)
//let blueColor = UIColor(red: 0.502, green: 0.749, blue: 1.0, alpha: 0.9)
let blueColor = UIColor(red: 115.0/255.0, green: 188.0/255.0, blue: 230.0/255.0, alpha: 1.0)

enum CellState {
    case targeted
    case hit
    case ship
    case empty
}


class Cell : UIView{
    let state : CellState
    init(x: CGFloat, y: CGFloat, state: CellState = .empty){
        self.state = state
        super.init(frame:CGRect(x: 0, y: 0, width: cellWidth-2, height: cellWidth-2))
        self.center = CGPoint(x: (x+0.5)*CGFloat(cellWidth), y: (y+0.5)*CGFloat(cellWidth))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let ship : String = "🚢"
        guard let context = UIGraphicsGetCurrentContext() else  { return }
        var fillColor : CGColor
        switch self.state {
        case .targeted:
            fillColor = targetedColor.cgColor
        case .hit:
            fillColor = hitColor.cgColor
        case .ship:
            fillColor = shipColor.cgColor
        default:
            fillColor = blueColor.cgColor
        }
        context.setFillColor(fillColor)
        context.fill(bounds)
        if self.state == .ship{
            ship.draw(in: rect)
        }
    }
}

class GridBattle: UIView {
    var xmin = 0
    var xmax = cellWidth*10
    var ymin = 0
    var ymax = cellWidth*10
    
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: 350, height: 350))
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else  { fatalError("arg") }
        
        xmin = Int(self.bounds.minX)
        xmax = xmin + cellWidth*10
        ymin = Int(self.bounds.minY)
        ymax = ymin + cellWidth*10
        
        context.setFillColor(blueColor.cgColor)
        context.setStrokeColor(UIColor.black.cgColor)
        
        let background = CGRect(x: xmin, y: ymin, width: xmax, height: ymax)
        context.addRect(background)
        context.drawPath(using: .fill)
        
        context.setLineWidth(0.5)
        for x in (0 ... xmax) where x % cellWidth == 0 {
            context.addLines(between: [CGPoint(x: xmin+x, y: ymin),CGPoint(x: xmin+x, y: ymax)])
        }
        for y in (0 ... ymax) where y % cellWidth == 0 {
            context.addLines(between: [CGPoint(x: xmin, y: ymin+y),CGPoint(x:xmax, y: ymin+y)])
        }
        context.drawPath(using: .stroke)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let textStyle = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 16)!, NSAttributedString.Key.paragraphStyle: paragraphStyle]
        
        let legendeX = CGRect(x: xmin, y: ymax, width: xmax, height: cellWidth)
        context.setFillColor(UIColor.white.cgColor)
        context.addRect(legendeX)
        context.drawPath(using: .fill)
        
        for i in 0...9{
            String(i).draw(in: CGRect(x: xmin+i*cellWidth, y: ymax+4, width: cellWidth, height: cellWidth),withAttributes: textStyle)
        }
        
        let legendeY = CGRect(x: xmax, y: ymin, width: cellWidth, height: ymax+cellWidth)
        context.setFillColor(UIColor.white.cgColor)
        context.addRect(legendeY)
        context.drawPath(using: .fill)
        for i in 0...9{
            String(i).draw(in: CGRect(x: xmax, y: ymin+i*cellWidth+4, width: cellWidth, height: cellWidth),withAttributes: textStyle)
        }
    }
    private func setPos(x: Int, y: Int, state: CellState){
        let cell = Cell(x: CGFloat(x), y: CGFloat(y),state:state)
        self.addSubview(cell)
    }
    func setPosTargeted(x: Int, y: Int){
        self.setPos(x: x, y: y, state: .targeted)
    }
    func setPosHit(x: Int, y: Int){
        self.setPos(x: x, y: y, state: .hit)
        
    }
    func setShipAt(x: Int, y: Int){
        self.setPos(x: x, y: y, state: .ship)
    }
    func emptyAt(x: Int, y: Int){
        self.setPos(x: x, y: y, state: .empty)
    }
}

// ----------------------------------------------------------------------------------------------
// --------------------------------------- Controller  ------------------------------------------
// ----------------------------------------------------------------------------------------------


class SeaBattleController: UIViewController, UITextFieldDelegate {
    var label : UILabel!
    //    var interface : Interface!
    var seaview : GridBattle!
    
    let labelX = UILabel()
    let labelY = UILabel()
    let labelWon = UILabel()
    let textFieldX = UITextField()
    let textFieldY = UITextField()
    let shoot = UIButton(type: .roundedRect)
    let display = UIButton(type: .roundedRect)
    let labelResult = UILabel()
    
    var battle : TBattle!
    
    var shouldDisplayShips : Bool = true
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        self.seaview = GridBattle()
        view.addSubview(seaview)
        //
//       if traitCollection.userInterfaceStyle == .dark{
//          labelX.textColor = .blue
//          labelY.textColor = .blue
//          labelResult.textColor = .secondaryLabel
//          textFieldX.textColor = .blue
//          textFieldY.textColor = .blue
//       }
       labelX.textColor = .blue
       labelY.textColor = .blue
       textFieldX.textColor = .blue
       textFieldY.textColor = .blue

       self.labelX.text = "X = "
        labelX.translatesAutoresizingMaskIntoConstraints = false
        self.labelY.text = "Y = "
        labelY.translatesAutoresizingMaskIntoConstraints = false
        //
        self.labelResult.textColor = shipColor
        self.labelResult.text = "no position targeted"
        self.labelResult.font = UIFont(name: "HelveticaNeue-Italic", size: 14)
        self.labelResult.textAlignment = .center
        labelResult.translatesAutoresizingMaskIntoConstraints = false
        //
        self.labelWon.textColor = hitColor
        self.labelWon.text = ""
        self.labelWon.font = UIFont(name: "HelveticaNeue-Bold", size: 24)
        self.labelWon.textAlignment = .center
        labelWon.translatesAutoresizingMaskIntoConstraints = false
        
        textFieldX.translatesAutoresizingMaskIntoConstraints = false
        textFieldX.placeholder = "n° col"
        textFieldX.delegate = self
        
        textFieldY.translatesAutoresizingMaskIntoConstraints = false
        textFieldY.placeholder = "n° ligne"
        textFieldY.delegate = self
        
        view.addSubview(labelX)
        view.addSubview(labelY)
        view.addSubview(labelResult)
        view.addSubview(labelWon)
        //
        view.addSubview(textFieldX)
        view.addSubview(textFieldY)
        
        self.shoot.setTitle("shoot", for: .normal)
        self.shoot.setTitleColor(hitColor, for: .normal)
        self.shoot.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(shoot)
        
        self.display.setTitle("display", for: .normal)
        self.display.setTitleColor(targetedColor, for: .normal)
        self.display.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(display)
        
        
        let margins = view.layoutMarginsGuide
        
        let height = self.seaview.bounds.height
        
        NSLayoutConstraint.activate([
            labelX.topAnchor.constraint(equalTo: margins.topAnchor, constant: height),
            labelX.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 0),
            labelY.leadingAnchor.constraint(equalTo: labelX.leadingAnchor, constant: 0),
            labelY.topAnchor.constraint(equalTo: labelX.bottomAnchor, constant: 10),
            labelX.widthAnchor.constraint(equalTo: labelY.widthAnchor, constant: 0),
            textFieldX.leadingAnchor.constraint(equalTo: labelX.trailingAnchor, constant: 5),
            textFieldX.topAnchor.constraint(equalTo: labelX.topAnchor, constant: 0),
            textFieldY.leadingAnchor.constraint(equalTo: labelY.trailingAnchor, constant: 5),
            textFieldY.topAnchor.constraint(equalTo: labelY.topAnchor, constant: 0),
            textFieldX.widthAnchor.constraint(equalTo: textFieldY.widthAnchor, constant: 0),
            shoot.topAnchor.constraint(equalTo: labelY.bottomAnchor,constant: 5),
            shoot.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            labelResult.leadingAnchor.constraint(equalTo: shoot.trailingAnchor, constant: 20),
            labelResult.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 20),
            labelResult.centerYAnchor.constraint(equalTo: shoot.centerYAnchor, constant: 0),
            display.centerYAnchor.constraint(equalTo: shoot.centerYAnchor,constant: 0),
            display.trailingAnchor.constraint(equalTo: shoot.leadingAnchor, constant: -20),
            labelWon.centerYAnchor.constraint(equalTo: labelX.bottomAnchor,constant: 5),
            labelWon.leadingAnchor.constraint(equalTo: textFieldX.trailingAnchor,constant: 5),
            labelWon.trailingAnchor.constraint(equalTo: margins.trailingAnchor,constant: 0)
        ])
        
        
        self.view = view
        
        self.shoot.addTarget(self, action: #selector(shootTarget), for: .touchUpInside)
        self.display.addTarget(self, action: #selector(displayShips), for: .touchUpInside)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // ----------------------------------------------------------------------------------------------
    // ----------------------------------- Programme Principal  -------------------------------------
    // ----------------------------------------------------------------------------------------------
    
    
    @objc func shootTarget() {
        self.labelResult.text = "no position targeted"
        guard let xs = self.textFieldX.text else { return }
        guard !xs.isEmpty else { return}
        guard let ys = self.textFieldY.text else { return }
        guard !ys.isEmpty else { return}
        guard let x = Int(xs) else { return }
        guard let y = Int(ys) else { return }
        guard (x >= 0) && (x<10) && (y>=0) && (y<10) else { return }
        if self.battle.shootAt(x: x, y: y){
            self.seaview.setPosHit(x:x, y: y)
            self.labelResult.text = "Touché !"
        }
        else{
            self.seaview.setPosTargeted(x:x, y: y)
            if self.battle.isSeenFrom(x: x, y: y){
                self.labelResult.text = "En vue"
            }
            else{
                self.labelResult.text = "À l'eau"
            }
        }
        if self.battle.endOfBattle{
            self.labelWon.text = "You Win !!!"
            self.shoot.isEnabled = false
            self.display.isEnabled = false
            self.textFieldY.isEnabled = false
            self.textFieldX.isEnabled = false
        }
        
    }
    
    @objc func displayShips() {
        for x in 0...9{
            for y in 0...9{
                if self.battle.isOccupied(x: x, y: y){
                    if self.shouldDisplayShips{
                        self.seaview.setShipAt(x: x, y: y)
                    }
                    else{
                        self.seaview.emptyAt(x: x, y: y)
                    }
                }
            }
        }
        self.shouldDisplayShips = !self.shouldDisplayShips
    }
}

let controller = SeaBattleController()


// ----------------------------------------------------------------------------------------------
// ---------------------------------------- Fin solutions ---------------------------------------
// ----------------------------------------------------------------------------------------------

//#-end-hidden-code

//: # TD Type Abstrait : implémentation d'un type (`struct`) conforme aux spécifications (`protocol`)


/*:
 
 ### Présentation du problème
 
 L'objectif est de programmer une bataille navale.
 
 Votre programme devra stocker 5 bateaux à des positions prédéterminées et immuables, chaque bateau occupant 1 seule case, sur une grille 10x10, numérotée de 0 à 9 sur chaque coordonnée
 
 Le programme devra demander à l'utilisateur une position où tirer, ceci tant que tous les bateaux ne sont pas coulés.\
 À chaque proposition, l'algorithme répond :
 - « coulé » si la position est celle d'un bateau
 - « en vue » si l'une des deux coordonnées est bonne
 - « à l'eau » si aucune des positions n'est bonne.
 Le programme doit permettre éventuellement à l'utilisateur de savoir où il a déjà tiré.
 
 Nous avons défini le type abstrait `TBattle`ainsi :
 
 - **init**: `➝ TBattle`
 
    Création d'un `TBattle` : initialise le champ de bataille en plaçant *n* bateaux sur la grille ; les positions occupées par les *n* bateaux placés sont occupées, aucun bateau n'est coulé et aucune case n'est touchée, la bataille n'est pas terminée.
    - shipsStillAlive(init())==*n*

 
 - **shipsStillAlive**: `TBattle ➝ Int`
 
    nombre de bateaux qui n'ont pas encore été coulés
    - shipsStillAlive(b) == *n* - *s* où *s* est le nombre de bateaux coulés
 
 - **isOccupied**: `TBattle x Int x Int ➝ Bool`
 
    La position (x,y) est-elle occupée par un bateau qui n'a pas encore été coulé
    - *isOccupied(b,x,y) => setShip(b,x,y) && !isHitAt(b,x,y)
 
 - **isHitAt**: `TBattle x Int x Int ➝ Bool`

    A-t-on tiré sur (x,y) ?
    - *isHitAt(shoot(b,x,y),x,y) == true* || *(isHitAt(init(),x,y) == false)*
 
 - **setShipAt**: `TBattle x Int x Int ➝ TBattle`
 
    place un bateau à la position (x,y) ; le nombre de bateaux encore en vie est incrémenté
    - isOccupied(setShip(b,x,y)) || isSunk(shoot(setShipAt(b,x,y),x,y),x,y)
    - shipsStillAlive(setShip(b,x,y)) == shipsStillAlive(b) + 1

 - **shootAt**: `TBattle x Int x Int ➝ TBattle x Bool`
 
    Tire sur la position (x,y)
    - shootAt(setShip(b,x,y),x,y) == true => isOccupied(b,x,y)
    - shootAt(b,x,y) == false => !isOccupied(b,x,y)
    - (bs,s) = shootAt(b,x,y) alors isHit(bs) == True
    - (bs,s) = shootAt(b,x,y) alors shipsStillAlive(bs) == shipsStillAlive(b)-1
 
 - **endOfBattle**: `TBattle ➝ Bool`
 
    la bataille est-elle finie ?
    - endOfBattle(b) => shipsStillAlive(b) == 0

 - **isSeenFrom**: `TBattle x Int x Int ➝ Bool`
    
    un bateau encore en vie est-il encore présent sur la même ligne et/ou colonne ?
    - isSeenFrom(b,x,y) => isOccupied(x,l) || isOccupied(c,y) pour tout 0 ≤ l,c < 10

 Le protocole `TBattle` définit le type abstrait bataille.
 ````
 protocol TBattle{
 init()
 var shipsStillAlive : Int{ get }
 func isOccupied(x: Int, y: Int) -> Bool
 func isHitAt(x: Int, y:Int) -> Bool
 mutating func setShipAt(x:Int, y: Int)
 mutating func shootAt(x: Int,y: Int) -> Bool
 var endOfBattle : Bool { get }
 func isSeenFrom(x: Int, y: Int) -> Bool
 }
 ````
 
 Votre objectif est d'implémenter le type concret `BatailleNavale` dont le squelette vous est donnée à l'**exercice 1**. Grâce à l'interface graphique vous pourrez tester si votre implémentation est bien conforme aux spécifications.
 
 À la fin du playground, vous trouverez les lignes suivantes :
 ````
 controller.battle = Battle()
 //controller.battle = BatailleNavale()
 ````
 `Battle` est une implémentation concrète du type et vous permettra de vérifier si votre propre implémentation est conforme. En décommentant la seconde ligne, vous testerez avec le type concret `BatailleNavale`, c'est à dire votre propre solution.
 
 Comme vous le remarquerez, les fonctions de `BatailleNavale` se contentent pour l'instant de renvoyer une valeur quelconque, ceci pour permettre la compilation et tester sans avoir encore tout implémenté. Au cours des exercices, vous allez devoir implémenter les fonctions une à une en modifiant cette implémentation.
 > Nous vous conseillons de copier/coller à chaque fois votre solution précédente dans le nouvel exercice, et de commenter l'ancienne afin de garder une trace des solutions aux différents exercices.
 */






/*:
 ### Gestion des « cases » du champs de Bataille
 
 Afin de faciliter l'implémentation du type `TBattle`, on a décidé de représenter chaque case du champ de bataille par le type abstrait `TLocation` :
 - **init**: `➝ Location ` // Création d'une `TLocation` : elle ne contient pas de bateau et n'a pas été touchée
 
 *(isHit(init())==`false`)* && *(shipHasBeenSet(init()) == false)*
 - **isOccupied**: `Location ➝ Bool`// la `TLocation` est-elle occupée en ce moment ?
 
 *isOccupied(l) => shipHasBeenSet(l) && !isHit(l)*
 - **isHit**: `Location ➝ Bool` // la `TLocation` a-t-elle été visée (`shoot`) ?
 
 *(isHit(l) => shoot(l))*
 - **isSunk**: `Location ➝ Bool` // Un bateau a-t-il été coulé à cette `Location`?
 
 *isSunk(l) => shipHasBeenSet(l) && isHit(l)*
 - **shipHasBeenSet**: `TLocation  ➝ Bool` // Un bateau a-t-il été placé sur cette `TLocation` ? Il peut avoir été coulé depuis.
 
 *shipHasBeenSet(l) => setShip(l)*
 - **setShip**: `Location ➝ Location` // Place un bateau sur la `TLocation`
 
 *shipHasBeenSet(setShip(l))==True*
 - **shoot**: `Location ➝ Location` // tire sur la `TLocation`
 
 *isHit(shoot(l) == True*
 
 Il est implémenté par le protocole :
 ````
 protocol TLocation{
 init()
 var isOccupied : Bool { get }
 var isHit : Bool { get }
 var isSunk : Bool { get }
 var shipHasBeenSet : Bool { get }
 mutating func setShip()
 mutating func shoot()
 }
 ````
 et un type concret `Location` est défini et implémenté, prêt à l'emploi.
 
 Le type `Battle` utilise d'ailleurs le type `Location` pour l'implémentation de ses fonctions et la défition de la structure de données représentant le champ de bataille. Vous pouvez aussi l'utiliser, cela vous permettra de gagner du temps.
 */




/*:
 ### **Exercice 1:** Création du champ de bataille.
 
 Pour cet exercice, la bataille ne contiendra aucun bateau.\
 Vous devez implémenter les fonctions `init` et `isOccupied(AtX:Y:)`\
 Vous vérifierez que votre implémentation est conforme en utilisant votre type et en testant en appuyant sur le bouton `display` qui permet d'afficher les bateaux. Normalement, le code doit s'exécuter sans erreur et ne doit rien afficher (puisque votre initialisation ne place aucun bateau).
 
 */

struct BatailleNavale : TBattle{
    
    /**
    grid: `TBattle ➝ [[TLocation]]`
     Tableau de tableaux contenant des TLocation.
     Devrait être de taille 10 x 10.
     */
    private var grid : [[TLocation]]
    
    
    /**
     shipsStillAlive: `TBattle ➝ Int`
     nombre de bateaux qui n'ont pas encore été coulés
     - shipsStillAlive(b) == *n* - *s* où *s* est le nombre de bateaux coulés.
     */
    private(set) var shipsStillAlive : Int
    
    
    /**
     Création d'un `TBattle` : initialise le champ de bataille en plaçant n bateaux sur la grille ; les positions occupées par les n bateaux placés sont occupées, aucun bateau n'est coulé et aucune case n'est touchée, la bataille n'est pas terminée.
     - shipAlive(init()) == n
     */
    init() {
        self.shipsStillAlive = 0
        self.grid = [[Location]](repeating: [Location](repeating: Location(), count: 10), count: 10)
        
        // (0,0),(3,5),(8,5),(2,9),(7,6). Position des différents bateaux.
        setShipAt(x: 0, y: 0)
        setShipAt(x: 3, y: 5)
        setShipAt(x: 8, y: 5)
        setShipAt(x: 2, y: 9)
        setShipAt(x: 7, y: 6)
    }
    
    
    /**
     isOccupied: `TBattle x Int x Int ➝ Bool`
     La position (x,y) est-elle occupée par un bateau qui n'a pas encore été coulé ?
     */
    func isOccupied(x: Int, y: Int) -> Bool {
        /*
             - **shipHasBeenSet**: `TLocation  ➝ Bool` // Un bateau a-t-il été placé sur cette `TLocation` ? Il peut avoir été coulé depuis.
             *shipHasBeenSet(l) => setShip(l)*
         */
        return self.grid[x][y].shipHasBeenSet && !isHitAt(x: x, y: y)
    }
    
    
    /**
     isHitAt: `TBattle x Int y Int ➝ Bool`
        A-t-on tiré sur (x,y) ?
        - isHitAt(shoot(b,x,y),x,y) == true || (isHitAt(init(),x,y) == false)
     Checks elf.grid[x][y].isHit
     */
    func isHitAt(x: Int, y:Int) -> Bool {
        return self.grid[x][y].isHit
        /*
            - **isHit**: `Location ➝ Bool` // la `TLocation` a-t-elle été visée (`shoot`) ?
             *(isHit(l) => shoot(l))*
         */
    }
    
    
    /**
     setShipAt: `TBattle x Int y Int ➝ TBattle`
        Place un bateau à la position (x,y) ; le nombre de bateaux encore en vie est incrémenté
        - isOccupied(setShip(b,x,y)) || isSunk(shoot(setShipAt(b,x,y),x,y),x,y)
        - shipsStillAlive(setShip(b,x,y)) == shipAlive(b) + 1
     */
    mutating func setShipAt(x:Int, y: Int){
        if !isOccupied(x: x, y: y) {
            self.shipsStillAlive += 1
            /*
                 - **setShip**: `Location ➝ Location` // Place un bateau sur la `TLocation`
                 *shipHasBeenSet(setShip(l))==True*
             */
            self.grid[x][y].setShip()
        }
    }
    
    
    /**
     shootAt: `TBattle x Int y Int ➝ TBattle x Bool`
        Tire sur la position (x,y)
        - isOccupied(b,x,y) == true => shipAlive -= 1
        - isOccupied(b,x,y) == true =>  self.grid[x][y].shoot()
        - isOccupied(b,x,y) == false => false
     */
    mutating func shootAt(x: Int,y: Int) -> Bool {
        if isOccupied(x: x, y: y) {
            self.shipsStillAlive -= 1
        }
        self.grid[x][y].shoot()
        return self.grid[x][y].shipHasBeenSet
        
        /*
             - **shoot**: `Location ➝ Location` // tire sur la `TLocation`
             *isHit(shoot(l) == True*
         */
    }
    
    
    /**
     endOfBattle: `TBattle ➝ Bool`
        La bataille est-elle finie ?
        - endOfBattle(b) => shipsStillAlive(b) == 0
     */
    var endOfBattle : Bool {
        return shipsStillAlive == 0
    }
    
    /**
     isSeenFrom**: `TBattle x Int y Int ➝ Bool`
        Un bateau encore en vie est-il encore présent sur la même ligne et/ou colonne ?
        - isSeenFrom(b,x,y) => isOccupied(x,l) || isOccupied(c,y) pour tout 0 ≤ l,c < 10
     */
    func isSeenFrom(x: Int, y: Int) -> Bool {
        // Fake for which can return true while looping.
        for i in 0...9 {
            if isOccupied(x: x, y: i) || isOccupied(x: i, y: y) {
                return true
            }
        }
        return false
    }
}



/*:
 ### **Exercice 2:** Ajout de bateaux sur le champ de bataille.
 
 Implémentez la fonction `setShip(x:y:)` permettant de placer des bateaux sur le champ de bataille.\
 Modifiez votre fonction `init` pour placer des bateaux aux positions suivantes : `(0,0),(3,5),(8,5),(2,9),(7,6)`
 
 Vous vérifierez que votre implémentation est conforme en utilisant votre type et en testant en appuyant sur le bouton `display`. Cette fois-ci vous devriez voir apparaitre les bateaux sur le champ de bataille. Vous pouvez comparer votre résultat avec celui du type `Battle`
 */


/*:
 ### Exercice 3: Tir sur les bateaux
 
 Implémentez la fonction `shootAt(x:y)` permettant de tirer sur une position de la grille.\
 Implémentez également la fonction `isHitAt(x:y)` qui permet de dire si une case a été touchée.
 
 Vous vérifierez que votre implémentation est conforme en utilisant votre type et en testant en appuyant sur le bouton `shoot` après avoir saisi des coordonnées de tir. Pour rappel, si un bateau est touché/coulé, le programme doit afficher une case rouge, si c'est manqué, une case vert-gris
 > on ne gère pas encore le cas en vue.
 > si votre implémentation est correcte, après avoir coulé au moins un bateau, appuyer sur le bouton `display` ne devrait faire apparaître que les bateaux encore en vie.
 */


/*:
 ### Exercice 4: En vue !
 
 Implémentez la fonction `isSeenFrom(x:y)` permettant de savoir si un bateau est en vue depuis `(x,y)`.
 
 Comme à l'exercice précédent, vous vérifierez votre implémentation grâce au bouton `shoot`. Si le tir est manqué et qu'un bateau est en vue, en plus de l'affichage de la case en gris pour indiquer qu'elle a été touchée, le texte « *en vue* » doit s'afficher.
 */



/*:
### Exercice 5: Fin...

Implémentez la propriété `endOfBattle` permettant de savoir si la partie est terminée.

Comme à l'exercice précédent, vous vérifierez votre implémentation en jouant une partie grâce au bouton `shoot`. Une fois tous les bateaux coulés, le jeux devrait se bloquer et indiquer que vous avez gagné.
*/




//controller.battle = Battle()
controller.battle = BatailleNavale()
PlaygroundPage.current.liveView = controller



