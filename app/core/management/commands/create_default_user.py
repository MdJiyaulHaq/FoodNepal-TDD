from django.core.management.base import BaseCommand, CommandError
from django.contrib.auth import get_user_model

User = get_user_model()


class Command(BaseCommand):
    help = "Create a superuser with specified email and password"

    def add_arguments(self, parser):
        parser.add_argument(
            "--email",
            type=str,
            required=True,
            help="Email for the superuser",
        )
        parser.add_argument(
            "--password",
            type=str,
            required=True,
            help="Password for the superuser",
        )
        parser.add_argument(
            "--name",
            type=str,
            default="Admin",
            help="Name for the superuser (optional)",
        )

    def handle(self, *args, **options):
        email = options["email"]
        password = options["password"]
        name = options["name"]

        if User.objects.filter(email=email).exists():
            raise CommandError(f"User with email {email} already exists")

        User.objects.create_superuser(
            email=email,
            password=password,
            name=name,
        )
        self.stdout.write(self.style.SUCCESS(f"✅ Superuser created!\nEmail: {email}"))
