import OrderLeaflet from "./orderLeaflet";


const OrderMap = {
  mounted() {

    this.map = new OrderLeaflet(this.el, [-22.74470633413637, -47.34198859499476], event => {

    })

    const orders = JSON.parse(this.el.dataset.orders);
    orders.forEach(order => {
      this.map.addMarker(order)
    })
  }
}

export default OrderMap;