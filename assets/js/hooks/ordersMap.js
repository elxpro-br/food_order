const OrdersMap = {
    mounted() {
        console.log(this.el.dataset.selectPoint)
        this.pushEvent("load_orders", {}, (reply, ref) => {
            console.log(reply)
        })
    }
}

export default OrdersMap;
