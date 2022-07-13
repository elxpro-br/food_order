import OrderLeaflet from "./orderLeaflet";


const OrderMap = {
  mounted() {

    this.map = new OrderLeaflet(this.el, [-22.74470633413637, -47.34198859499476], event => {
      const orderId = event.target.options;
      this.pushEvent("marker-clicked", orderId, (reply, ref) => {
        this.scrollTo(reply.order.id)
      })
    })

    this.pushEvent("get-orders", {}, (reply, ref) => {
      reply.orders.forEach(order => {
        this.map.addMarker(order)
      })
    })

    // const orders = JSON.parse(this.el.dataset.orders);
    // orders.forEach(order => {
    //   this.map.addMarker(order)
    // })

    this.handleEvent("highlight-marker", order => {
      this.map.highlightMarker(order)
    })

    this.handleEvent("add-marker", order => {
      this.map.addMarker(order)
      this.map.highlightMarker(order)
      this.scrollTo(order.id)
    })
  },
  scrollTo(orderId) {
    const order = document.querySelector(`[phx-value-id="${orderId}"]`);
    order.scrollIntoView(false)
  }
}

export default OrderMap;