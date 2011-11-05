using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Collections.Specialized;
using System.Configuration.Provider;
using QuanLyDoDac.Models;

namespace QuanLyDoDac.Services
{
    public class RoleProviderIml : RoleProvider
    {
        #region Attributes
        private string _applicationName;
        #endregion

        #region Properties
        public override string ApplicationName
        {
            get { return _applicationName; }
            set { _applicationName = value; }
        }
        #endregion

        #region function
        public override void Initialize(string name, NameValueCollection config)
        {
            if (config == null)
            {
                throw new ArgumentNullException("config");
            }

            if (String.IsNullOrEmpty(name))
            {
                name = "RoleProviderIml";
            }

            if (String.IsNullOrEmpty(config["description"]))
            {
                config.Remove("description");
                config.Add("description", "Implement Role provider");
            }

            // Initialize the abstract base class.
            base.Initialize(name, config);

            try
            {
                _applicationName = GetConfigValue(config["applicationName"], System.Web.Hosting.HostingEnvironment.ApplicationVirtualPath);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public override void AddUsersToRoles(string[] usernames, string[] roleNames)
        {
            foreach (string roleName in roleNames)
            {
                if (!RoleExists(roleName))
                {
                    throw new ProviderException("Role name not found.");
                }
            }

            foreach (string username in usernames)
            {
                if (username.Contains(","))
                {
                    throw new ArgumentException("User names cannot contain commas.");
                }

                foreach (string roleName in roleNames)
                {
                    if (IsUserInRole(username, roleName))
                    {
                        throw new ProviderException("User is already in role.");
                    }
                }
            }

            try
            {
                QuanLyDoDacEntities db = new QuanLyDoDacEntities();
                foreach (string username in usernames)
                {
                    foreach (string roleName in roleNames)
                    {
                        UserInRole userInRole = new UserInRole();
                        userInRole.UserId = db.Users.Single(m => m.Username.ToLower().Equals(username.ToLower())).Id;
                        userInRole.RoleId = db.Roles.Single(m => m.Name.ToLower().Equals(roleName.ToLower())).Id;
                        db.UserInRoles.AddObject(userInRole);
                        db.SaveChanges();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public override void CreateRole(string roleName)
        {
            if (roleName.Contains(","))
            {
                throw new ArgumentException("Role names cannot contain commas.");
            }

            if (RoleExists(roleName))
            {
                throw new ProviderException("Role name already exists.");
            }

            try
            {
                QuanLyDoDacEntities db = new QuanLyDoDacEntities();
                Role role = new Role();
                role.Name = roleName;
                db.Roles.AddObject(role);
                db.SaveChanges();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public override bool DeleteRole(string roleName, bool throwOnPopulatedRole)
        {
            if (!RoleExists(roleName))
            {
                throw new ProviderException("Role does not exist.");
            }

            if (throwOnPopulatedRole && GetUsersInRole(roleName).Length > 0)
            {
                throw new ProviderException("Cannot delete a populated role.");
            }

            try
            {
                QuanLyDoDacEntities db = new QuanLyDoDacEntities();
                db.Roles.DeleteObject(db.Roles.Single(m => m.Name.ToLower().Equals(roleName.ToLower())));
                db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public override string[] GetAllRoles()
        {
            try
            {
                QuanLyDoDacEntities db = new QuanLyDoDacEntities();
                return db.Roles.Select(m => m.Name).ToArray();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public override string[] GetRolesForUser(string username)
        {
            try
            {
                QuanLyDoDacEntities db = new QuanLyDoDacEntities();
                return (
                           from ur in db.UserInRoles
                           join u in db.Users on ur.UserId equals u.Id
                           join r in db.Roles on ur.RoleId equals r.Id
                           where u.Username.ToLower().Equals(username.ToLower())
                           select r.Name
                       ).ToArray();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public override string[] GetUsersInRole(string roleName)
        {
            try
            {
                QuanLyDoDacEntities db = new QuanLyDoDacEntities();
                return (
                           from ur in db.UserInRoles
                           join u in db.Users on ur.UserId equals u.Id
                           join r in db.Roles on ur.RoleId equals r.Id
                           where r.Name.ToLower().Equals(roleName.ToLower())
                           select u.Username
                       ).ToArray();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public override bool IsUserInRole(string username, string roleName)
        {
            try
            {
                QuanLyDoDacEntities db = new QuanLyDoDacEntities();
                int num = (
                              from ur in db.UserInRoles
                              join u in db.Users on ur.UserId equals u.Id
                              join r in db.Roles on ur.RoleId equals r.Id
                              where r.Name.ToLower().Equals(roleName.ToLower()) &&
                                    u.Username.ToLower().Equals(username.ToLower())
                              select ur
                          ).Count();
                if (num > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public override void RemoveUsersFromRoles(string[] usernames, string[] roleNames)
        {
            foreach (string roleName in roleNames)
            {
                if (!RoleExists(roleName))
                {
                    throw new ProviderException("Role name not found.");
                }
            }

            foreach (string username in usernames)
            {
                foreach (string roleName in roleNames)
                {
                    if (!IsUserInRole(username, roleName))
                    {
                        throw new ProviderException("User is not in role.");
                    }
                }
            }

            try
            {
                QuanLyDoDacEntities db = new QuanLyDoDacEntities();
                foreach (string username in usernames)
                {
                    foreach (string roleName in roleNames)
                    {
                        UserInRole userInRole = (
                                                    from ur in db.UserInRoles
                                                    join u in db.Users on ur.UserId equals u.Id
                                                    join r in db.Roles on ur.RoleId equals r.Id
                                                    where r.Name.ToLower().Equals(roleName.ToLower()) &&
                                                          u.Username.ToLower().Equals(username.ToLower())
                                                    select ur
                                                ).Single();
                        db.UserInRoles.DeleteObject(userInRole);
                        db.SaveChanges();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public override bool RoleExists(string roleName)
        {
            try
            {
                QuanLyDoDacEntities db = new QuanLyDoDacEntities();
                int numRecs = db.Roles.Where(m => m.Name.ToLower().Equals(roleName.ToLower())).Count();
                if (numRecs > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public override string[] FindUsersInRole(string roleName, string usernameToMatch)
        {
            try
            {
                QuanLyDoDacEntities db = new QuanLyDoDacEntities();
                return (
                           from ur in db.UserInRoles
                           join u in db.Users on ur.UserId equals u.Id
                           join r in db.Roles on ur.RoleId equals r.Id
                           where r.Name.ToLower().Equals(roleName.ToLower()) &&
                                 u.Username.ToLower().Contains(usernameToMatch.ToLower())
                           select u.Username
                       ).ToArray();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private string GetConfigValue(string configValue, string defaultValue)
        {
            if (string.IsNullOrEmpty(configValue))
            {
                return defaultValue.Trim();
            }

            return configValue.Trim();
        }
        #endregion
    }
}