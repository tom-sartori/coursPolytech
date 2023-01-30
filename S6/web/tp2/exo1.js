// // Vous partez sur Mars et vous ne pouvez emporter que 1000 kgs de nourritures
//
// const food = [
//     ['potatoes', 800], //[food, kg]
//     ['rice', 200],
//     ['wheatFlour', 400],
//     ['peanutButter', 10],
//     ['tomatoesCans', 300],
//     ['beans', 300],
//     ['strawberryJam',50]
// ]
//
// const maxWeight = 1000
//
// function getThings () {
//     food.sort( function (a, b) {
//         return b[1] - a[1]
//     })
//
//     console.log(food)
//
//     let result = []
//     let currentWeight = 0
//     let i = 0
//
//     while (food[i] !== undefined) {
//         if (currentWeight + food[i][1] <= maxWeight) {
//             result.push(food[i])
//             currentWeight += food[i][1]
//         }
//         i++
//     }
//
//     console.log("Weight : " + currentWeight + " | " + result)
// }
//
//
//
// getThings()
//
//
// // Faites un algorithme qui emporte tout ce qu'il peut du plus gros au moins gros
//
//
// // 4.1 Naïf: emporter tant que le poids est inférieur à 1000 Kg ce qui est le plus lourd
//
// // hint: utiliser la fonction sort: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/sort
//
//
// // 4.2  au plus proche prenez du plus gros au moins gros et lorsque cela dépasserait les 1000 kgs complétés avec le plus gros qui rentre encore etc.
//
// // hint: Utilisez la fonction slice https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/slice