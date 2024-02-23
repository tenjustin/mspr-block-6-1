using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace plant_app_backend.Migrations
{
    /// <inheritdoc />
    public partial class ConnToFront : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Photos",
                table: "Annonces",
                newName: "Ville");

            migrationBuilder.AddColumn<DateTime>(
                name: "DateCreation",
                table: "Annonces",
                type: "TEXT",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<DateTime>(
                name: "DateModification",
                table: "Annonces",
                type: "TEXT",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<string>(
                name: "ImageName",
                table: "Annonces",
                type: "TEXT",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<double>(
                name: "Latitude",
                table: "Annonces",
                type: "REAL",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<double>(
                name: "Longitude",
                table: "Annonces",
                type: "REAL",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<double>(
                name: "Price",
                table: "Annonces",
                type: "REAL",
                nullable: false,
                defaultValue: 0.0);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "DateCreation",
                table: "Annonces");

            migrationBuilder.DropColumn(
                name: "DateModification",
                table: "Annonces");

            migrationBuilder.DropColumn(
                name: "ImageName",
                table: "Annonces");

            migrationBuilder.DropColumn(
                name: "Latitude",
                table: "Annonces");

            migrationBuilder.DropColumn(
                name: "Longitude",
                table: "Annonces");

            migrationBuilder.DropColumn(
                name: "Price",
                table: "Annonces");

            migrationBuilder.RenameColumn(
                name: "Ville",
                table: "Annonces",
                newName: "Photos");
        }
    }
}
