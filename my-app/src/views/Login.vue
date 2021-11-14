<template>
  <Navigation />
  <div class="login">
    <div style="
    background-color: #e7e9eb; 
    width: 400px;
    padding: 20px;
    margin: auto;
    box-shadow: 12px 12px 2px 1px #42b983;">
      <form @submit.prevent="submit">
        <div>
          <label for="username">Username:</label>
          <input type="text" name="username" v-model="form.user" />
        </div>
        <div>
          <label for="password">Password:</label>
          <input type="password" name="password" v-model="form.password" />
        </div>
        <button type="submit">Login</button>
      </form>
      <p v-if="showError" id="error">Username or Password is incorrect</p>
    </div>
  </div>
</template>

<script>
import Navigation from "@/components/Navigation";
import axios from "axios";
import { mapActions } from "vuex";

export default {
  name: "Login",
  components: {
    Navigation,
  },
  data() {
    return {
      form: {
        user: "",
        password: "",
      },
      showError: false,
    };
  },

  methods: {
    ...mapActions(["logIn"]),
    async submit() {
      const response = await axios.post("login", {
        user: this.user,
        password: this.password,
      });
      localStorage.setItem("token", response.data.token);
      try {
        await this.logIn();
        this.$router.push("/profile");
        this.showError = false;
      } catch (e) {
        this.showError = true;
      }
    },
  },
};
</script>

<style scoped>
.login {
  padding-top: 120px;
}
* {
  box-sizing: border-box;
}
label {
  padding: 12px 12px 12px 0;
  display: inline-block;
}
button[type="submit"] {
  background-color: #42b983;
  color: white;
  padding: 12px 20px;
  cursor: pointer;
  border-radius: 30px;
}
button[type="submit"]:hover {
  background-color: #42b983;
}
input {
  margin: 5px;
  box-shadow: 0 0 15px 4px rgba(0, 0, 0, 0.06);
  padding: 10px;
  border-radius: 30px;
}
#error {
  color: red;
}
</style>