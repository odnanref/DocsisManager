<?php

/**
 * Cria as acls para os recursos de sistema
 *
 * @author andref
 *
 */

class Users_Plugin_AclFactory
{
	/**
	 * Creates an ACL for a specific page
	 *
	 * @param String|Zend_Db_Table_Abstract $target
	 * @param Page $page
	 *
	 * @return Zend_Acl
	 */
	public function createAcl($target, Page $page)
	{
		//Lets assume we have a model for the page_privileges with a method like this
		//which would return PagePrivilege objects with the page_id passed as the param.
		$target = new Far_Access_Privilege($target);
		$privileges = $target->findById($page->getId());

		$acl = new Zend_Acl();
		$acl->addResource($page->getId());

		foreach($privileges as $privilege) {
			$acl->addRole(new Zend_Acl_Role($privilege->getUserId()));
			$acl->allow($privilege->getUserId(), $page->getId());
		}

		return $acl;
	}
}
