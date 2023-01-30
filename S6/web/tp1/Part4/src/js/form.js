console.log(window.location.pathname + " loaded. ");

const formStudent = document.getElementById("formStudent");
const inputFormStudentValidate = document.getElementById("inputFormStudentValidate");



inputFormStudentValidate.onclick = function (event) {
    event.preventDefault();

    tryToAddStudent();
}

function tryToAddStudent() {
    let listValue = [];
    let isFormValid = true;

    for (let elt of formStudent) {
        if (!elt.checkValidity()) {
            isFormValid = false;
            console.log("Invalid form");
            break;
        }
        else {
            listValue.push(elt.value);
        }
    }

    if (isFormValid) {
        listValue = listValue.slice(0, -1);
        // console.log(listValue);
        addStudent(listValue[0], listValue[1], listValue[2], listValue[3]);
        clearForm();
    }
}

function clearForm() {
    for (let elt of formStudent) {
        if (elt.type !== "submit") {
            elt.value = "";
        }
    }
}

