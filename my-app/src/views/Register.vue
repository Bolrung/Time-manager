<template>
  <Navigation />
  <div class="register">
    <div style="
    background-color: #e7e9eb; 
    width: 400px;
    padding: 20px;
    margin: auto;
    box-shadow: 12px 12px 2px 1px #42b983;">
      <form @submit.prevent="submit">
        <div>
          <label for="username">Username:</label>
          <input type="text" name="username" v-model="form.username" />
        </div>
        <div>
          <label for="email">Email Address:</label>
          <input type="text" name="email" v-model="form.email" />
        </div>
        <div>
          <label for="password">Password:</label>
          <input type="password" name="password" v-model="form.password" />
        </div>
        <button type="submit">Sign Up</button>
      </form>
    </div>
    <p v-if="showError" id="error">Username already exists</p>
  </div>
</template>

<script>
import Navigation from "@/components/Navigation";
import { mapActions } from "vuex";
import axios from "axios";

export default {
  name: "Register",
  components: {
    Navigation,
  },
  data() {
    return {
      form: {
        username: null,
        submitted: false,
        successful: false,
        message: "",
      },
      showError: false,
    };
  },
  methods: {
    ...mapActions(["registerUser"]),
    async submit() {
      const response = await axios.post("register", {
        username: this.username,
        email: this.email,
        password: this.password,
      });
      localStorage.setItem("token", response.data.token);
      this.registerUser(this.form.username);
      try {
        await this.registerUser(this.form);
        this.$router.push("/profile");
        this.showError = false;
      } catch (error) {
        this.showError = true;
      }
    },
  },
};
</script>

<style scoped>
.register {
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