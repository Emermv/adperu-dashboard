<template>
  <q-page class="flex flex-center">
         <q-page-sticky expand position="top">
        <q-toolbar class="GPLAY__sticky bg-white q-px-xl">
          <q-space />
          <q-btn icon="help" dense flat size="12px" class="GPLAY__sticky-help" />
          <q-btn icon="settings" dense flat class="GPLAY__sticky-settings q-ml-md" size="12px" />
        </q-toolbar>
      </q-page-sticky>
      <div ref="container" style="width:100%; height:400px;"></div>

  </q-page>
</template>

<script>
export default {
  name: 'Report',
  data(){
    // <img alt="Quasar logo" src="~assets/quasar-logo-full.svg">
    return {
      data:[]
    }
  },
  created(){
    
    this.$socket.on("data",(data)=>{
     console.log("new data",data) 
        this.chart.series[0].setData(data);
    });
    this.$socket.on("drilldown",(drilldown)=>{
     this.chart.hideLoading();
     this.chart.addSeriesAsDrilldown(this.active_point,{
         name:this.active_point.options.name,
         id:this.active_point.options.drilldown,
         data:drilldown,
         colorByPoint:true
     } );
    });
    
  },
  mounted(){
      this.$Drilldown(this.$H);
       this.$socket.emit("getData");
this.chart=this.$H.chart(this.$refs.container, {
  chart: {
    type: 'column',
      events:{
    drilldown:(e)=>{
        console.log("drilldown",e)
        this.chart.showLoading("Obteniendo datos, espere por favor!");
        this.active_point=e.point;
        this.$socket.emit('getDrilldown',e.point.options.id);
    

    }
  },
  },
  title: {
    text: 'Campañas'
  },
  subtitle: {
    text: 'Leads por campaña'
  },
  xAxis: {
    type: 'category'
  },
  yAxis: {
    title: {
      text: 'Total de leads'
    }

  },
  legend: {
    enabled: false
  },
  plotOptions: {
    series: {
      borderWidth: 0,
      dataLabels: {
        enabled: true,
        format: '{point.y}'
      }
    }
  },

  tooltip: {
    headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
    pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y}</b> del total<br/>'
  },

  series: [
    {
      name: "Campañas",
      colorByPoint: true,
      data:this.data
    }
  ],
  drilldown: {
    series: []
  }
});
  }
}
</script>
