import "net/http"

type jsonResponse struct {
	Erro    bool   `json:"error"`
	Message string `json:"message"`
	Data    any    `json:"data,omitempty"`
}

func (app *Config) Broker(w http.ResponseWritter, r *http.Request) {
	payload := jsonResponse{
		Error:   false,
		Message: "Hit the Broker",
	}

	out, _ = json.MarshalIndent(payload, "", "\t")
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusAccepted)
	w.Write(out)

}