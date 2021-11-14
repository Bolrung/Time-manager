<template>
  <header :class="{ 'scrolled-nav': scrolledNav}">
      <nav>
          <div class="branding">
              <img src="@/assets/hourglass.png" alt="clock"/>
              <h3 style="color:#42b983">Time Manager</h3>
          </div>
          <ul v-show="!mobile" class="navigation">
              <li><router-link class="link" to="/">Home</router-link></li>
              <li class="nav-item">
              <router-link to="/register" class="link">
              <font-awesome-icon icon="user-plus" />Sign Up
              </router-link>
              </li>
              <li class="nav-item">
              <router-link to="/login" class="link">
              <font-awesome-icon icon="sign-in-alt" />Login
              </router-link>
              </li>
              <li><router-link class="link" to="/createUser">Users</router-link></li>
              <li><router-link class="link" to="/Workingtimes">Working times</router-link></li>
              <li><router-link class="link" to="/Workingtime">Working time</router-link></li>
              <li><router-link class="link" to="/ClockManager">Clock Manager</router-link></li>
          </ul>
          <div class="icon">
              <i @click="toggleMobileNav" v-show="mobile" class="far fa-bars" :class="{'icon-active' : mobileNav}"></i>
          </div>
          <transition name="mobile-nav">
            <ul v-show="!mobileNav" class="dropdown-nav">
              <li><router-link class="link" to="/">Home</router-link></li>
              <li><router-link class="link" to="/createUser">Users</router-link></li>
              <li><router-link class="link" to="/Workingtimes">Working times</router-link></li>
              <li><router-link class="link" to="/Workingtime">Working time</router-link></li>
              <li><router-link class="link" to="/ClockManager">Clock Manager</router-link></li>
            </ul>
          </transition>
      </nav>
  </header>
</template>

<script>
export default {
    name: "navigation",
    data() {
        return {
            scrolledNav: null,
            mobile: false,
            mobileNav: true,
            windowWidth: null
        };
    },
    created() {
        window.addEventListener("resize", this.checkScreen);
    },
    mounted() {
        window.addEventListener("scroll", this.updateScroll);
    },
    
    methods: {
        toggleMobileNav() {
            this.mobileNav = !this.mobileNav;
        },
        updateScroll() {
            const scrollPosition = window.scrollY;
            if(scrollPosition > 50) {
                this.scrolledNav = true;
                return;
            }
            this.scrolledNav = false;
        },
        checkScreen() {
            this.windowWidth = window.innerWidth;
            if(this.windowWidth <= 750) {
                this.mobile = true;
                return;
            }
            this.mobile = false;
            this.mobileNav = true;
            return;
        },
    },
};
</script>

<style lang="scss" scoped>
header {
     overflow: hidden;
     background-color: rgba(0, 0, 0, 0.8);
     z-index: 99;
     width: 100%;
     top: 0;
     left: 0;  
     position: fixed;
     transition: 0.5s ease all;
     color: #fff;

     nav {
         position: relative;
         display: flex;
         flex-direction: row;
         padding: 12px 0;
         transition: 0.5s ease all;
         width: 90%;
         margin: 0 auto;
         @media(min-width: 1140px) {
             max-width: 1140px;
         }
         ul,
         .link {
             font-weight: 500;
             color: #fff;
             list-style: none;
             text-decoration: none;
         }
         li {
             text-transform: uppercase;
             padding: 16;
             margin-left: 16px;
         }
         .link {
             font-size: 14px;
             transition: .5 ease all;
             padding-bottom: 4px;
             border-bottom: 1px solid transparent;

             &:hover {
                 color: #fff;
                 border-color: #fff;
             }
         }
         .branding {
             display: flex;
             align-items: center;

             img {
                 width: 50px;
                 transition: 0.5s ease all;
             }
         }
         .navigation {
             display: flex;
             align-items: center;
             flex: 1;
             justify-content: flex-end;
         }
         .icon {
             display: flex;
             align-items: center;
             position: absolute;
             top: 0;
             right: 24px;
             height: 100%;

             i {
                 cursor: pointer;
                 font-size: 24px;
                 transition: 0.8s ease all;
             }
         }
         .icon-active {
             transform: rotate(180);
         }

         .dropdown-nav {
             display: flex;
             flex-direction: column;
             position: fixed;
             width: 100%;
             max-width: 200px;
             height: 100%;
             background-color: #383434;
             top: 0;
             left: 0;
             height: 100%;

             li {
                 margin-left: 0;
                 .link {
                     color: #000;
                 }
             }
         }
         .mobile-nav-enter-active,
         .mobile-nav-leave-active {
             transition: 1s ease all;
         }
         .mobile-nav-enter-from,
         .mobile-nav-leave-to {
             transform: translateX(-250px);
         }
         .mobile-nav-enter-to {
             transform: translateX(0);
         }
     }
}

.scrolled-nav {
    background-color: #D3D3D3;
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);

    nav {
        padding: 5px 0;

        .branding {
            img {
                width: 40px;
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            }
        }
    }
}
</style>