using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace plant_app_backend.Migrations
{
    /// <inheritdoc />
    public partial class AjoutUserId : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Annonces_User_UserId",
                table: "Annonces");

            migrationBuilder.DropIndex(
                name: "IX_Annonces_UserId",
                table: "Annonces");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateIndex(
                name: "IX_Annonces_UserId",
                table: "Annonces",
                column: "UserId");

            migrationBuilder.AddForeignKey(
                name: "FK_Annonces_User_UserId",
                table: "Annonces",
                column: "UserId",
                principalTable: "User",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
