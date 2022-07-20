import OrderLeaflet from "../orderMap/orderLeaflet";

const OrderStatusMap = {
  mounted() {
    const order = JSON.parse(this.el.dataset.order);
    this.map = new OrderLeaflet(this.el, [order.latitude, order.longitude], event => {})
    this.map.addMarker(order)
    navigator.geolocation.watchPosition(e => {
      const lat = e.coords.latitude      
      const lng = e.coords.longitude      
      point = {
        latitude: lat,
        longitude: lng,
        id: 123,
        name: "pumpkin"
      }
      this.map.addDriverMarker(point)
      this.pushEvent("watch_app", {lat: lat, lng: lng})
    })

  }
}

export default OrderStatusMap;