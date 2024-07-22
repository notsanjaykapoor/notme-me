import contextlib
import os

import fastapi
import fastapi.middleware
import fastapi.middleware.cors
import fastapi.templating


@contextlib.asynccontextmanager
async def lifespan(app: fastapi.FastAPI):
    yield


# initialize templates dir
templates = fastapi.templating.Jinja2Templates(directory="routers")

# create app object
app = fastapi.FastAPI(lifespan=lifespan)

app.add_middleware(
    fastapi.middleware.cors.CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def home():
    return fastapi.responses.RedirectResponse("/me")


@app.get("/me", response_class=fastapi.responses.HTMLResponse)
def me(request: fastapi.Request):
    version = os.environ.get("APP_VERSION") or "notme"
    return templates.TemplateResponse(request, "me.html", {"app_version": version})
