import OrderLeaflet from "./orderLeaflet";


const OrderMap = {
  mounted() {

    this.map = new OrderLeaflet(this.el, [-22.74470633413637, -47.34198859499476], event => {
      const orderId = event.target.options;
      this.pushEvent("marker-clicked", orderId)
    })

    const orders = JSON.parse(this.el.dataset.orders);
    orders.forEach(order => {
      this.map.addMarker(order)
    })

    this.handleEvent("highlight-marker", order => {
      this.map.highlightMarker(order)
    })

    this.handleEvent("add-marker", order => {
      console.log(order)
      this.map.addMarker(order)
      this.map.highlightMarker(order)
    })
  }
}

export default OrderMap;