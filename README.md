# Food-Nepal

A **TDD-First Django REST API** for recipe management with comprehensive test coverage.

**Stack**: Django 5.2 | DRF | PostgreSQL | Docker | Pytest

## Test Credentials

Email: `test@gmail.com`
Username: `test`
Password: `newuser@123`

## Quick Start

```bash
# Start local environment
docker-compose -f docker-compose.local.yml up

# Run tests (from another terminal)
docker exec food-nepal-web-1 pytest

# Run specific test file
docker exec food-nepal-web-1 pytest app/core/tests/test_models.py -v

# Run with coverage
docker exec food-nepal-web-1 pytest --cov=app
```

## Testing Structure

- **Unit Tests**: `app/core/tests/test_models.py` - Model logic & custom user manager
- **API Tests**: `app/recipe/tests/` - Recipe, tags, ingredients endpoints
- **Admin Tests**: `app/core/tests/test_admin.py` - Django admin integration
- **Integration**: `app/core/tests/test_health_check.py` - Health check endpoint

## API Endpoints

- Health Check: `GET /api/health/`
- `POST /api/users/create` - Register
- `POST /api/users/token` - Get token
- `GET/POST /api/recipes/` - Recipes (authenticated)
- `GET/POST /api/tags/` - Tags
- `GET/POST /api/ingredients/` - Ingredients

## License

MIT
