import OrderLeaflet from "./orderLeaflet";


const OrderMap = {
  mounted() {

    this.map = new OrderLeaflet(this.el, [ -22.74470633413637, -47.34198859499476], event => {
      
    })
  }
}

export default OrderMap;