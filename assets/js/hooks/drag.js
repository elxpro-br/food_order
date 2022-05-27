import Sortable from "sortablejs";
const Drag = {
    mounted() {
      const hook = this;
      console.log(hook)
      const selector = "#" + hook.el.id

      document.querySelectorAll('.dropzone').forEach(dropzone => {
        new Sortable(dropzone, {
            animation: 0,
            delay: 50,
            delayOnTouchOnly: true,
            group: 'shared',
            draggable: 'draggable',
            ghostClass: 'sortable-ghost',
            onEnd: function(evt) {
                console.log(evt)
            
               hook.pushEventTo(selector, 'dropped', {
                 order_id: evt.item.id
               })

            }
        })
      })
    }
}

export default Drag;