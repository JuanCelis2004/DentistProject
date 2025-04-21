/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/ClientSide/javascript.js to edit this template
 */


$(document).ready(function () {
    $("body").on('click', ".form-horizontal", function () {
        $(".form").toggleClass("form-horizontal");
        $(".signupForm").toggle();
    });
});