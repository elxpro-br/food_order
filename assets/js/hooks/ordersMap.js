import OrdersLocationMap from "./ordersMap/ordersLocationMap";

const OrdersMap = {
    mounted() {
        selectPoint = JSON.parse(this.el.dataset.selectPoint)

        this.map = new OrdersLocationMap(this.el, [selectPoint.latitude, selectPoint.longitude], event => {
            const orderId = event.target.options.orderId;
            this.pushEvent("marker-clicked", {id: orderId}, (reply, ref) => {
                this.scrollTo(reply.orderId.id);
            })
        })

        this.pushEvent("load_orders", {}, (reply, ref) => {
            reply.orders.forEach(order => {this.map.addMarker(order)})
        })

        this.handleEvent("highlight-marker", e => {
            this.map.highlightMarker(e)
        })
    },
    scrollTo(orderId) {
        const orderElement = document.querySelector(`[phx-value-id="${orderId}"]`);
        orderElement.scrollIntoView(false);
    }
}

export default OrdersMap;
