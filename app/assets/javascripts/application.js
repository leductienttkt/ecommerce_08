// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .

$(document).ready(function(){
  $(document).on('click','.signup-tab',function(e){
    e.preventDefault();
    $('#signup-taba').tab('show');
  });

  $(document).on('click','.signin-tab',function(e){
    e.preventDefault();
    $('#signin-taba').tab('show');
  });

  $(document).on('click','.forgetpass-tab',function(e){
    e.preventDefault();
    $('#forgetpass-taba').tab('show');
  });

  $(document).on('click', 'input[type=radio]', function(){
    $('#rate-form form').submit();
    alert('Thanks for rating this product');
  });
});

('turbolinks:load',function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v2.8&appId=595799547290473";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

(function() {var pname = ( (document.title !='')? document.title : document.querySelector('h1').innerHTML );
  var ga = document.createElement('script'); 
  ga.type = 'text/javascript'; ga.async=1; 
  ga.src = '//live.vnpgroup.net/js/web_client_box.php?hash=ff35e7fb0d201d4afc7287789512cec7&data=eyJzc29faWQiOjMzMzEzMTYsImhhc2giOiJlMzljODk4Mzg1OWM1NjhkOTJlMzNiOTZkZGU2OTU3NyJ9&pname='+pname;
  var s = document.getElementsByTagName('script');
  s[0].parentNode.insertBefore(ga, s[0]);})();
