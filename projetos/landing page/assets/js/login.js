class validaFormulario {
    constructor() {
        this.formulario = document.querySelector('.formulario');
        this.eventos();
    }

    eventos() {
        this.formulario.addEventListener('submit', e => {
            this.handleSubmit(e);
        });
    }

    handleSubmit(e) {
        e.preventDefault();
        const camposValidos = this.camposSaoValidos();
        const senhasValidas = this.senhasSaoValidas();

        if (camposValidos && senhasValidas) {
            alert('formulário enviado');
            this.formulario.submit();
        }
    }
    senhasSaoValidas() {
        let valid = true;

        const senha = this.formulario.querySelector('.current-password');
        const repetirSenha = this.formulario.querySelector('.repetir_current-password');
        if (senha.value.length < 6 || senha.value.length > 12) {
            valid = false;
            this.criaErro(senha, 'Senha precisa estar entre 6 e 12 caracteres')
        }

        return valid;
    }
    camposSaoValidos() {
        let valid = true;

        for (let errorText of this.formulario.querySelectorAll('.error-text')) {
            errorText.remove();
        }

        // nesse for estamos iterando sobre todos os elementos do formulario que tem a class validar e verifica se estiver vazio, para então mandar uma mensagem de erro

        for (let campo of this.formulario.querySelectorAll('.validar')) {
            if (!campo.value) {
                this.criaErro(campo, `preencha todos os campos`);
                valid = false;
            }
            if (campo.classList.contains('user')) {
                if (!this.validaUsuario(campo)) valid = false;
            }
        }
    }

    validaUsuario(campo) {
        const Usuario = this.formulario.querySelector('.user');
        let valid = true;

        if (Usuario.value.length < 3 || Usuario.value.length > 30) {
            valid = false;
            this.criaErro(Usuario, 'Usuario precisa estar entre 6 e 30 caracteres')
        }

        // como validar email para ver se tem @, pesquisar depois com expressões linear, se não me engano tem no curso 

        // if (!Usuario.match(/^[a-zA-Z0-9]+$/g)) {
        //     this.criaErro(campo, 'Nome de usuário precisar conter apenas letras e/ou números.');
        //     valid = false;
        //     console.log('erro');
        // }

        return valid;
    }

    criaErro(campo, msg) {
        const div = document.createElement('div');
        div.innerHTML = msg;
        div.classList.add('error-text');
        campo.insertAdjacentElement('afterend', div);
    }
}

const valida = new validaFormulario();

function lookPassword() {
    const pass = document.getElementById('password');
    const iconPass = document.getElementById('iconPass');

    if (pass.type === 'password') {
        pass.setAttribute('type', 'text');
        iconPass.classList.replace('bi-eye-fill', 'bi-eye-slash-fill');
    }
    else {
        pass.setAttribute('type', 'password');
        iconPass.classList.replace('bi-eye-slash-fill', 'bi-eye-fill');
    }
}