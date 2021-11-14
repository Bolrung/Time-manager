<template>
<Navigation />
<div class="form">
  <h2 style="
    background-color: #e7e9eb;
    padding: 15px;">Working time LineChart</h2>
  <div style="max-width: 600px" class="chart1">
    <p>
    this LineChart demonstrates the working time recorded by the API for every user.
    </p>
    <vue3-chart-js v-bind="{ ...lineChart }" />
  </div>
  <br>
  <div style="width:50%;Text-align:center;float:left;">
    <vue3-chart-js v-bind="{ ...barChart }" />
  </div>
  <div style="Text-align:right;Width:50%;float:right">
    <vue3-chart-js v-bind="{ ...doughnutChart }" />
  </div>
  </div>
</template>

<script>
import Navigation from "@/components/Navigation";
import axios from 'axios'
import Vue3ChartJs from "@j-t-mcc/vue3-chartjs";
import zoomPlugin from "chartjs-plugin-zoom";
import dataLabels from "chartjs-plugin-datalabels";

// globally registered and available for all charts
Vue3ChartJs.registerGlobalPlugins([zoomPlugin]);

export default {
    name: "workingtimes",
    components: {
    Vue3ChartJs,
    Navigation
  },
  setup() {
      const doughnutChart = {
      type: "doughnut",
      data: {
        labels: ["User1", "User2", "User3", "User3"],
        datasets: [
          {
            backgroundColor: ["#41B883", "#E46651", "#00D8FF", "#DD1B16"],
            data: [40, 20, 80, 10],
          },
        ],
      },
    };
      const barChart = {
      type: "bar",
      options: {
        min: 0,
        max: 100,
        responsive: true,
        plugins: {
          legend: {
            position: "top",
          },
        },
        scales: {
          y: {
            min: -100,
            max: 100,
            ticks: {
              callback: function (value) {
                return `${value}%`;
              },
            },
          },
        },
      },
      data: {
        labels: ["User1", "User2", "User3", "User4"],
        datasets: [
          {
            label: "My First Dataset",
            backgroundColor: ["#1abc9c", "#f1c40f", "#2980b9", "#34495e"],
            data: [40, 20, 50, 10],
          },
          {
            label: "My Second Dataset",
            backgroundColor: ["#2ecc71", "#e67e22", "#9b59b6", "#bdc3c7"],
            data: [-40, -20, -10, -10],
          },
        ],
      },
    };
      const lineChart = {
          type: "line",
          plugins: [dataLabels],
          data: {
              labels: [
                  "start",
                  "end"
              ],
              datasets: [
                  {
                    label: "Working time",
                    data: [65, 59],
                    fill: false,
                    borderColor: "#41B883",
                    backgroundColor: "black",
                   },
                   {
                     label: "Not Working time",
                     data: [70, 25],
                     fill: false,
                     borderColor: "#00D8FF",
                     tension: 0.5,
                     backgroundColor: "blue", 
                   },
              ],
          },
          options: {
              plugins: {
                  zoom: {
                      wheel: {
                          enabled: true,
                      },
                      pinch: {
                          enabled: true,
                      },
                      mode: "y",
                  },
              },
              datalabels: {
                  backgroundColor: function (context) {
                      return context.dataset.backgroundColor;
                  },
                  borderRadius: 4,
                  color: "white",
                  font: {
                      weight: "bold",
                  },
                  formatter: Math.round,
                  padding: 6,
                  },
        },
      };
    return {
      lineChart, barChart, doughnutChart
    };
    
  },
  methods: {
        getWorkingTimes(){
            console.log(this.workingtimes);
            let url = "localhost:4000/api/workingtimes/:userid/:id"

            axios.get(url,{workingtimes:this.user}).then((a) => {
                a
            }).catch((e) => {console.log(e);
           });
        }

    }
};

</script>

<style>
.chart1 {
  display: block;
  margin-left: auto;
  margin-right: auto;
  width: 40%;
}

.form {
   padding-top: 150px; 
   }
</style>