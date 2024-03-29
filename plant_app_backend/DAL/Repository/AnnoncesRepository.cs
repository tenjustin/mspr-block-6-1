﻿using Microsoft.AspNetCore.Authorization;
using plant_app_backend.Configuration;
using plant_app_backend.DAL.Models;
using plant_app_backend.DAL.Repository.Interface;

namespace plant_app_backend.DAL.Repository
{
    public class AnnoncesRepository : IAnnoncesRepository
    {
        private readonly ApplicationDbContext _context;

        public AnnoncesRepository(ApplicationDbContext context)
        {
            _context = context;
        }

        public void InsertAnnonce(Annonces annonce)
        {
            _context.Annonces.Add(annonce);

            try
            {
                _context.SaveChanges();
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public List<Annonces> GetAllAnnoncesByVille(string ville)
        {
            var annonces = _context.Annonces.Where(a => a.Ville == ville).ToList();
            return annonces;
        }

        public string GetImageName(int id)
        {
            var annonce = _context.Annonces.FirstOrDefault(a => a.Id == id);
            return annonce.ImageName;
        }

        public Annonces GetAnnonceById(int id)
        {
            var annonce = _context.Annonces.FirstOrDefault(a => a.Id == id);
            return annonce;
        }
    }
}
