import LeafletMap from "./leafletMap";

const OrderMap = {
    mounted() {

        this.map = new LeafletMap(this.el, [-22.730565923794114, -47.33515636980927], event => {})

        const orders = JSON.parse(this.el.dataset.orders);
        orders.forEach(order => {
            this.map.addMarker(order)
        });
    }
}

export default OrderMap;