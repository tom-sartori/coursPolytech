const food = [
    {name:'potatoes', weight:800, totalKCal:1501600},     //  [food, kg, kcal]
    {name:'rice', weight:300, totalKCal:1122000},
    {name:'wheatFlour', weight:400, totalKCal:1444000},
    {name:'beans', weight:300, totalKCal:690000},
    {name:'tomatoesCans', weight:300, totalKCal:273000},
    {name:'strawberryJam', weight:50, totalKCal:130000},
    {name:'peanutButter', weight:20, totalKCal:117800}
]

const maxWeight = 1000

function ex1 () {
    food.sort(function (a, b) {
        return b.totalKCal - a.totalKCal
    })
    console.log(food)

    console.log("Max Kcal : " + getMaxKcal())
}

function ex2 () {
    food.sort(function (a, b) {
        return (b.totalKCal / b.weight) - (a.totalKCal / a.weight)
    })
    console.log(food)

    console.log("Max Kcal : " + getMaxKcal())
}

function getMaxKcal () {
    let currentWeight = 0
    let currentKCal = 0
    let i = 0

    while (i < food.length && currentWeight <= maxWeight) {
        if (currentWeight + food[i].weight <= maxWeight) {
            currentWeight += food[i].weight
            currentKCal += food[i].totalKCal
        }
        i++
    }
    return currentKCal
}


ex1()
ex2()


// Problème: choisissez n'importe quel nombre d'articles dans le collection, sans avoir la chance de prendre une
// fraction d'un article, de sorte que leur poids total ne dépasse pas 1000 kg, et de telle manière que la quantité
// totale de calories soit maximisée


// Exo 1: prendre les boites qui contiennent le plus de calories au total d'abord

// hint: vous devriez atteindre  1,749,400 calories


// Exo 2:Prendre les boites par le plus de calories au kg

//hint: vous devriez atteindre 2,813,800 calories


// Exo 3 (hors du cours): faites les permutations pour trouver la meilleur solution (problème NP-complet)

//hint: vous devriez atteindre 3,256,000 calories