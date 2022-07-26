"""
Django command to wait for the database to be available.
"""
import time

from psycopg2 import OperationalError as Psycopg2OError

from django.db.utils import OperationalError
from django.core.management.base import BaseCommand


class Command(BaseCommand):
    """Django command to wait for database."""

    def handle(self, *args, **options):
        """Entrypoint for commands."""
        self.stdout.write("Waiting for database to be available...")
        db_up = False
        while db_up is False:
            try:
                self.check(databases=["default"])
                db_up = True
            except (Psycopg2OError, OperationalError):
                self.stdout.write(
                    "Database is not available \
                    , waiting 1 second..."
                )
                time.sleep(1)

        self.stdout.write("Database is available.")
