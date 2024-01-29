using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace plant_app_backend.Models;

[Index("UserId", Name = "IX_Annonces_UserId")]
public partial class Annonce
{
    [Key]
    public int Id { get; set; }

    [Required]
    public string Titre { get; set; }

    [Required]
    public string Description { get; set; }

    [Required]
    public string Photos { get; set; }

    public int UserId { get; set; }

    public int IsAvailable { get; set; }

    [ForeignKey("UserId")]
    [InverseProperty("Annonces")]
    public virtual User User { get; set; }
}
