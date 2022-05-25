//var stage = 0;
function sendRegisterForm() {
    /*if(number > 0) {
        if(stage === 0) {
            stage = 1;
            document.getElementById("stage1").style.visibility = "hidden";
            document.getElementById("stage2").style.visibility = "visible";
            document.getElementById("stage2").style.zIndex = 1;
            document.getElementById("nextStage").innerText = "Gönder";
            document.getElementById("preStage").classList.remove("disabled");
            if(document.getElementById("appType").selectedIndex === 2) {
                document.getElementById("stage3").style.visibility = "visible";
            } else {
                document.getElementById("stage3").style.visibility = "hidden";
            }
        } else if(stage === 1) {
            if(controlRegisterForm()) {
                document.getElementById("registerForm").submit();
            }
        }
    } else {
        if(stage === 1) {
            stage = 0;
            document.getElementById("stage3").style.visibility = "hidden";
            document.getElementById("stage1").style.visibility = "visible";
            document.getElementById("stage2").style.visibility = "hidden";
            document.getElementById("nextStage").innerText = "Sonraki";
            document.getElementById("preStage").classList.add("disabled");
            document.getElementById("stage2").style.zIndex = 0;
        }
    }
    if(controlRegisterForm()) {
        document.getElementById("registerForm").submit();
    }*/


    if ($('#registerForm').parsley().validate()){
        document.getElementById("registerForm").submit();
    }
}

function controlRegisterForm() {

    //TODO: ADD MAX-MIN CHARACTER CONTROL
    var isItOk = true;
    /*if(document.getElementById("email").value === "") {
        isItOk = false;
        alert("Email bilginizi giriniz.");
        return;
    } else if(document.getElementById("firstName").value === "") {
        isItOk = false;
        alert("İsim bilginizi giriniz.");
    } else if(document.getElementById("lastName").value === "") {
        isItOk = false;
        alert("Soyadı bilginizi giriniz.");
    } else if(document.getElementById("inputPassword").value === "") {
        isItOk = false;
        alert("Şifre bilginizi giriniz.");
    } else if(document.getElementById("passwordAgain").value === "") {
        isItOk = false;
        alert("Şifre bilginizi tekrar giriniz.");
    } else if(document.getElementById("inputPassword").value !== document.getElementById("passwordAgain").value) {
        isItOk = false;
        alert("Girdiğiniz şifreler aynı değil.");
    } else if(!validateEmail(document.getElementById("email").value)) {
        isItOk = false;
        alert("Email bilginiz email@example.com formatında olmalıdır.");
        return;
    } else if(document.getElementById("firstName").value.length > 15) {
        isItOk = false;
        alert("İsim bilginiz en fazla 15 karakterden oluşabilir.");
    } else if(document.getElementById("lastName").value.length > 15) {
        isItOk = false;
        alert("Soyadı bilginiz en fazla 15 karakterden oluşabilir.");
    } else if(document.getElementById("inputPassword").value.length < 8 ||  document.getElementById("inputPassword").value.length > 12) {
        isItOk = false;
        alert("Şifre bilginiz en fazla 12, en az 8 karakterden oluşmalıdır.");
    }

    return isItOk;

    if(document.getElementById("passwordAgain").value !== document.getElementById("inputPassword").value) {
        document.getElementById("passwordagainerror").style.visibility = "visible";
        return false;
    }*/
    return true;
}