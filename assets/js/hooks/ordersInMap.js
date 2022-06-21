import OrderMap from "./orderMap/orderMap";

const OrdersInMap = {
    mounted() {
        console.log("here!!")
        this.map = new OrderMap(this.el, [-22.739210113439995, -47.34097003807723], event  => {})
    }
}

export default OrdersInMap;