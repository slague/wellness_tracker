$( document ).ready(function(){
  $('.goal-inc').on("click", updateProgressBar)
})

function updateProgressBar(event){
  var progressBar = this.parentElement.parentElement.children[1].children[0]
  var id = this.id

  $.ajax({
    type: 'put',
    url: `/goals/${id}/inc`
  }).success(incrementProgressBar.bind(null, id))
  .fail(error => console.error(error))
}

function incrementProgressBar(id, data){
  var value = (data.progress_count / data.total_goal_count * 100)
  var bar = $(`div[goal-id="${id}"]`)
  var parent = bar.parent()
  bar.detach()
  bar.css('width', value + '%')
  parent.append(bar)
  parent.siblings()[1].innerText = data.progress_count + "/" + data.total_goal_count
  // debugger
  if(data.progress_count == data.total_goal_count){
    $(parent.siblings()[0]).replaceWith(`<div class="icons"><img src="http://i.imgur.com/f7s3dQN.png" height="30" width="30"></div>`);
  }
}
