package org.easyas3.pool 
{
	/**
	 * ... 对象池 ...
	 * @author Jerry
	 * @version 1.1.0
	 */
	public class ObjectPool 
	{
		/**
		 * 对象池数据存储对象
		 */
		protected var _pool:Vector.<IPoolObject>;
		
		/**
		 * 使用中对象计数
		 */
		protected var _usingCount:uint;
		
		/**
		 * 闲置对象计数
		 * @private
		 */
		private var freeCount:uint;
		
		/**
		 * 池对象的类
		 */
		private var type:Class;
		
		/**
		 * 构造函数
		 * @param	type:Class —— 池对象的类
		 */
		public function ObjectPool(type:Class) 
		{
			this.type = type;
			_pool = new Vector.<IPoolObject>();
		}
		
		/**
		 * 对象池数据存储对象 - getter方法
		 */
		public function get pool():Vector.<IPoolObject> 
		{
			return _pool;
		}
		
		/**
		 * 使用中对象计数 - getter方法
		 */
		public function get usingCount():uint 
		{
			return _usingCount;
		}
		
		/**
		 * 最大可搜索范围
		 */
		public function get range():uint 
		{
			var poolObj:IPoolObject;
			var length:uint = _pool.length;
			var count:uint;
			
			for (var i:int = 0; i < length; i++) 
			{
				poolObj = _pool[i] as IPoolObject;
				
				if (poolObj.using)
				{
					count++;
					
					if (count >= _usingCount)
					{
						break;
					}
				}
			}
			
			i++;
			return (i <= length)?i:length;
		}
		
		/**
		 * 取出池对象
		 * @return
		 */
		public function getPoolObject():IPoolObject 
		{
			var poolObj:IPoolObject;
			
			if (freeCount > 0)
			{
				freeCount--;
				_usingCount++;
				
				for each (poolObj in _pool) 
				{
					if (!poolObj.using)
					{
						poolObj.using = true;
						return poolObj;
					}
				}
			}
			else
			{
				poolObj = new type();
				poolObj.using = true;
				_usingCount++;
				_pool.push(poolObj);
				return poolObj;
			}
			
			return null;
		}
		
		/**
		 * 释放池对象，并将其放回对象池内
		 * @param	value:IPoolObject —— 池对象
		 */
		public function releasePoolObject(value:IPoolObject):void 
		{
			_usingCount--;
			freeCount++;
			value.using = false;
			value.reset();
		}
		
		/**
		 * 释放所有池对象
		 */
		public function releaseAll():void 
		{
			var poolObj:IPoolObject;
			var length:uint = range;
			
			for (var i:int = 0; i < length; i++) 
			{
				poolObj = _pool[i] as IPoolObject;
				
				if (poolObj.using)
				{
					releasePoolObject(poolObj);
				}
			}
		}
		
		/**
		 * 销毁所有池对象
		 */
		public function dispose():void 
		{
			for each (var poolObj:IPoolObject in _pool) 
			{
				poolObj.dispose();
			}
			
			_pool.length = 0;
		}
	}

}