console.log(window.location.pathname + " loaded. ");

const tableTbodyStudent = document.getElementById("tableTbodyStudent");


addStudent("Sartori", "Tom", "tomsartori4@gmail.com", "IG");
addStudent("Masse", "Lalie", "lalie.masse@gmail.com", "IG");
addStudent("Bricot", "Judas", "judas.bricot@gmail.com", "IG");
addStudent("Abc", "Abc", "Abc", "Abc");


function addStudent(name, surname, mail, formation) {
    let tableRowElement = document.createElement("tr");

    tableRowElement.appendChild(createTdElement(name));
    tableRowElement.appendChild(createTdElement(surname));
    tableRowElement.appendChild(createTdElement(mail));
    tableRowElement.appendChild(createTdElement(formation));

    let tdButton = document.createElement("td");
    tdButton.appendChild(createButtonElement("buttonInfo", "button", "Information"));

    let buttonDelete = createButtonElement("buttonDelete", "button", "Supprimer");
    buttonDelete.onclick = function (event) {
        tableTbodyStudent.removeChild(event.target.parentNode.parentNode);
    }
    tdButton.appendChild(buttonDelete);

    tableRowElement.appendChild(tdButton);

    tableTbodyStudent.appendChild(tableRowElement);
}

function createTdElement (innerText) {
    let tableDataCellElement = document.createElement("td");
    tableDataCellElement.innerText = innerText;
    return tableDataCellElement;
}

function createButtonElement (className, type, innerText) {
    let buttonElement = document.createElement("button");

    buttonElement.className = className;
    buttonElement.type = type;
    buttonElement.innerText = innerText;

    return buttonElement;
}
