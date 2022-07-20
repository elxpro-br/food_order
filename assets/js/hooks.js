import ScrollProducts from "./hooks/scrollProducts";
import CartSession from "./hooks/cartSession";
import Drag from "./hooks/drag";
import OrderMap from "./hooks/orderMap/orderMap";
import OrderStatusMap from "./hooks/orderStatusMap/orderStatusMap";

let Hooks = {
    ScrollProducts: ScrollProducts,
    CartSession: CartSession,
    OrderMap: OrderMap,
    OrderStatusMap: OrderStatusMap,
    Drag: Drag
}

export default Hooks;