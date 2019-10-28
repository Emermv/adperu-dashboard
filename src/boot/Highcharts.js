import Drilldown from 'highcharts/modules/drilldown';
import Highcharts from 'highcharts';
import Vue from 'vue';
import io from 'socket.io-client';
Vue.prototype.$socket=io('http://localhost:4000');
Vue.prototype.$H=Highcharts
Vue.prototype.$Drilldown=Drilldown;
