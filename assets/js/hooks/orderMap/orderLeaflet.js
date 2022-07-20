import L from "leaflet";

class OrderLeaflet {
    constructor(element, center, markerClickedCallback) {
        this.map = L.map(element).setView(center, 13);
        const accessToken = "pk.eyJ1IjoiZ3V1aG9saSIsImEiOiJja2c5bTk2anEwMjd0MnJwbmlsaDlqdnBwIn0.5Hjtf-hQ0oNPoznzqUyGWQ";

        L.tileLayer(
            "https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}", {
                attribution: "Gustavo Oliveira",
                mapZoom: 40,
                id: "mapbox/streets-v11",
                tileSize: 512,
                zoomOffset: -1,
                accessToken: accessToken
            }
        ).addTo(this.map)
        this.markerClickedCallback = markerClickedCallback;

    }

    addMarker(order) {
        const marker = L.marker([order.latitude, order.longitude], {
                orderId: order.id
            })
            .addTo(this.map)
            .bindPopup(
                `
                    <h3>${order.user.email}</h3>
                    <span><strong>Total Price: </strong>${order.total_price}</span>
                    <br>
                    <span><strong>Number: </strong>${order.phone_number}</span>
                    <br>
                    <span><strong>Address: </strong>${order.address}</span>
                    <br>
                    <span><strong>Status: </strong>${order.status}</span>
                `
            )

        marker.on("click", e => {
            marker.openPopup();
            this.markerClickedCallback(e)
        });

        return marker;
    }

    addDriverMarker(driver) {
        const marker = L.marker([driver.latitude, driver.longitude], {
            driver: driver.id
            })
            .addTo(this.map)
            .bindPopup(
                `
                    <h3>${driver.name}</h3>
                `
            )

        marker.on("click", e => {
            marker.openPopup();
            this.markerClickedCallback(e)
        });

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
                if (markerPosition.lat === order.latitude && markerPosition.lng === order.longitude) {
                    markerLayer = layer;
                }
            }
        })
        return markerLayer;
    }


}

export default OrderLeaflet;