$( document ).ready(function(){
  $('.plus-sign').on("click", updateProgressBar)
})

function updateProgressBar(event){
  event.preventDefault;
  // var plusSign = this
  var progressBar = this.parentElement.children[1].children[0]
  var a = $(this).find('a')[0]
  var url = $(a).attr('href')
  // var method = $(a).attr('data-method')

  $.ajax({
    type: method,
    url: url,
    data
  }).done(incrementProgressBar);

}
      // $(progressBar).css({width: "((progress_count.to_f / total_goal_count.to_f) * 100).round}%")
      // the new width ="#{((progress_count.to_f / total_goal_count.to_f) * 100).round}%"
function incrementProgressBar(){
  // debugger
  $(progressBar).attr("aria-valuenow", "((progress_count.to_f / total_goal_count.to_f) * 100).round}")
}

// // ajax request to increment send the goal params
// // upon successful increment return  progress_count and total_goal_count
// // do the math here and change the css
// // .css selector  change width
