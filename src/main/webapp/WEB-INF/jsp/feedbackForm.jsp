<div id="hiddenBtns" class="hiddenBtns" style="display: block;">
    <button type="button" class="openLikeBtn" onclick="openForm()"></button>
</div>
<div class="chat-popup-backdrop" id="messageBackdrop" onclick="closeForm()"></div>
<div class="chat-popup" id="messageVue">
    <form class="form-container">
        <button type="button" id="close" onclick="closeForm()" class="closeForm" aria-label="Close">&times;</button>
        <h2 id="headMsg">Contact SCGE</h2>
        <input type="hidden" name="subject" value="Help and Feedback Form">
        <input type="hidden" name="found" value="0">

        <label><b>Your email</b></label>
        <input type="email" name="email" v-model="email" placeholder="you@example.com">

        <label><b>Message</b></label>
        <textarea placeholder="How can we help?" name="comment" v-model="message"></textarea>

        <button type="button" id="sendEmail" class="btn" v-on:click="sendMail">Send message</button>
    </form>
</div>




<script src="https://unpkg.com/vue@2.7.16/dist/vue.js"></script>
<script src="https://unpkg.com/axios@1.7.8/dist/axios.min.js"></script>
<script>
    function openForm() {
        document.getElementById("messageBackdrop").style.display = "block";
        document.getElementById("messageVue").style.display = "block";
        document.getElementById("headMsg").innerText = 'We value your feedback';
    }

    function closeForm() {
        document.getElementById("messageBackdrop").style.display = "none";
        document.getElementById("messageVue").style.display = "none";
        document.getElementById("sendEmail").disabled = false;
    }

    // window.onload = function () {
    var messageVue = new Vue({
        el: '#messageVue',
        data: {
            email: '',
            message: '',
        },
        methods: {
            sendMail: function () {
                if (this.message === '' || !this.message) {
                    alert("There is no message entered.");
                    return;
                }
                if (this.email === '' || !this.email) {
                    alert("No email provided.");
                    return;
                }
                if (!emailValidate(this.email)) {
                    alert("Not a valid email address.");
                    return;
                }
                document.getElementById("sendEmail").disabled = true;


                axios.post('/platform/data/feedback?${_csrf.parameterName}=${_csrf.token}',
                    {
                        email: messageVue.email,
                        message: messageVue.message,
                        webPage: window.location.href
                    })
                    .then(function (response) {
                        closeForm();
                        messageVue.email="";
                        messageVue.message="";
                        alert("Thank you!  Your message has been sent to the SCGE.")
                    }).catch(function (error) {
                    console.log(error)
                })
            }
        } // end methods
    });

    function emailValidate(message) {
        var re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return re.test(message);
    }


    if (sessionStorage.getItem("sawFeedback") === "true") {

    }else {
        sessionStorage.setItem('sawFeedback', 'true');
        //setTimeout("openForm()",4000);
    }



</script>
