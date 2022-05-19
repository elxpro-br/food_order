const CartSession = {
    mounted() {
        this.handleEvent("create-cart-session-id", map => {
            var {cartId: cartId} = map
            sessionStorage.setItem("cart_id", cartId)
        })
    }
}

export default CartSession;