import L from "leaflet";

class LeafletMap {
    constructor(element, center, markerClickedCallback) {
        const token = "pk.eyJ1IjoiZ3V1aG9saSIsImEiOiJja2c5bWVuaGwwc281MnNwZ3RtMjVlaWFuIn0.c8uUwyoB-wHJnrPEotEGSw";
        this.map = L.map(element).setView(center, 13);
        L.tileLayer(
            "https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}", {
                attribution: "Elxpro",
                maxZoom: 40,
                id: "mapbox/streets-v11",
                tileSize: 512,
                zoomOffset: -1,
                accessToken: token
            }
        ).addTo(this.map)

        this.markerClickedCallback = markerClickedCallback;
    }

    addMarker(order) {
        const marker = L.marker([order.lat, order.lng], {
                orderId: order.id
            })
            .addTo(this.map)
            .bindPopup(
                `
                <h3>${order.user.email}</h3>
                <strong>Total Price:</strong>${order.total_price}
                <br>
                <strong>Number:</strong>${order.phone_number}
                <br>
                <strong>Address:</strong>${order.address}
                <br>
                <strong>Status:</strong>${order.status}
                `
            )

        marker.on("click", e => {
            marker.openPopup()
            this.markerClickedCallback(e)
        })

        return marker;
    }

    highlightMarker(order) {
        const marker = this.markerForOrder(order);
        marker.openPopup()
        this.map.panTo(marker.getLatLng())
    }

    markerForOrder(order) {
        let markerLayer;
        this.map.eachLayer(layer => {
            if (layer instanceof L.Marker) {
                const markerPosition = layer.getLatLng();
                if(markerPosition.lat == order.lat && markerPosition.lng == order.lng) {
                    markerLayer = layer
                }
            }
        })
        return markerLayer;
    }
}

export default LeafletMap;