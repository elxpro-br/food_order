import Sortable from "sortablejs";
const Drag = {
  mounted() {
    const hook = this;
    const selector = "#" + hook.el.id
    const el = document.getElementById(hook.el.id)

    new Sortable(el, {
      group: 'shared',
      draggable: '.draggable',
      onEnd: function (evt) {
        hook.pushEventTo(selector, 'dropped', {
          order_id: evt.item.id,
          new_status: evt.to.id,
          old_status: evt.from.id,
        })

      }
    })
  }
}

export default Drag;