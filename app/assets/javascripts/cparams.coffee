# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
 Morris.Line({ 
  element: 'myfirstchart',
  data: [
    { year: '2008', value: 20 },
    { year: '2009', value: 10 },
    { year: '2010', value: 5 },
    { year: '2011', value: 5 },
    { year: '2017', value: 12 }
  ],
  xkey: 'year',
  ykeys: ['value'],
  labels: []
 });

 jQuery ->
 Morris.Line({ 
  element: 'rates_chart',
  data: $('#rates_chart').data('rates'),
  xkey: 'created_at',
  ykeys: ['curs'],
  labels: ['Curs']
 });
 
